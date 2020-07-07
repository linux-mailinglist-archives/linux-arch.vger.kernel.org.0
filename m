Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCA217488
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGGQ4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 12:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgGGQ4y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 12:56:54 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ECEC2065D;
        Tue,  7 Jul 2020 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594141014;
        bh=Pxamgvc2FYcqKzB/kO/K+pvItVmdREDTa9V2Uq/pm90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WfluW2mALu5v2u4IsB9+2+vbjc5luGQpkCpWji2UWyn5eJGKh2+w3PCRaCORF0/YN
         +46mUvg1IPuLlsjfbJFei4Opj8gC35QmxI1XVnc0h/gl29judPMY7nyXTpvF+QwI80
         oPi+MhkEYdPflHpFGc+lNEnz/Mg7+kCFEw68dC9I=
Date:   Tue, 7 Jul 2020 09:56:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200707095651.422f0b22@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200707160528.GA1300535@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
        <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
        <20200629232059.GA3787278@google.com>
        <20200707155107.GA3357035@google.com>
        <20200707160528.GA1300535@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 7 Jul 2020 09:05:28 -0700 Sami Tolvanen wrote:
> On Tue, Jul 07, 2020 at 08:51:07AM -0700, Sami Tolvanen wrote:
> > After spending some time debugging this with Nick, it looks like the
> > error is caused by a recent optimization change in LLVM, which together
> > with the inlining of ur_load_imm_any into jeq_imm, changes a runtime
> > check in FIELD_FIT that would always fail, to a compile-time check that
> > breaks the build. In jeq_imm, we have:
> > 
> >     /* struct bpf_insn: _s32 imm */
> >     u64 imm = insn->imm; /* sign extend */
> >     ...
> >     if (imm >> 32) { /* non-zero only if insn->imm is negative */
> >     	/* inlined from ur_load_imm_any */
> > 	u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
> > 
> >         /*
> > 	 * __imm has a value known at compile-time, which means
> > 	 * __builtin_constant_p(__imm) is true and we end up with
> > 	 * essentially this in __BF_FIELD_CHECK:
> > 	 */
> > 	if (__builtin_constant_p(__imm) && __imm <= 255)  
> 
> Should be __imm > 255, of course, which means the compiler will generate
> a call to __compiletime_assert.

I think FIELD_FIT() should not pass the value into __BF_FIELD_CHECK().

So:

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 48ea093ff04c..4e035aca6f7e 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -77,7 +77,7 @@
  */
 #define FIELD_FIT(_mask, _val)                                         \
        ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");     \
+               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");     \
                !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
        })
 
It's perfectly legal to pass a constant which does not fit, in which
case FIELD_FIT() should just return false not break the build.

Right?
