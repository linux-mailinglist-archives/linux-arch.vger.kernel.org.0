Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADEC3F13
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfJARzc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 13:55:32 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41812 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJARzc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 13:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+oEkJHYhGgqZ+vlSK1n3UKdeFsRUniJisnPzVCGMnuE=; b=l0XUyFpD/ksEi5w8pMe1zLaYY
        TrMiuvRdm523dZWLf+5Ic+6p1gLOlVT9ObXPpvX9FLs6X3BAAYMbKMyJaQ86lCGZPuioeMonTVmXU
        6jzSaxLycMOsoACiT0fkG+Vdbkfh+IlCgkKnHzTM3V1CxGU50xmtWucEtcGkHRxr5gHwEjyeVpnHn
        YksJ8fWPqolGnxLzfhAqDS8YgFljLsT44qYMLCNbUgVMnaApt8QEmZS3mDOuwwrK/LNl0jcWrv+BV
        zrSn6Bx5GmvOAKhUMqKX1dkEKRZJfXAdlyBmdgaZc8FZXqnNv/56KpYqfyFB3lEUGP9OwEDHrW7Ew
        RKvGIJYbA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:38844)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFMMm-0003rs-TF; Tue, 01 Oct 2019 18:55:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFMMi-0008OW-Gj; Tue, 01 Oct 2019 18:55:12 +0100
Date:   Tue, 1 Oct 2019 18:55:12 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001175512.GK25745@shell.armlinux.org.uk>
References: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> I apologize; I don't mean to be difficult.  I would just like to avoid
> surprises when code written with the assumption that it will be
> inlined is not.  It sounds like we found one issue in arm32 and one in
> arm64 related to outlining.  If we fix those two cases, I think we're
> close to proceeding with Masahiro's cleanup, which I view as a good
> thing for the health of the Linux kernel codebase.

Except, using the C preprocessor for this turns the arm32 code into
yuck:

1. We'd need to turn get_domain() and set_domain() into multi-line
   preprocessor macro definitions, using the GCC ({ }) extension
   so that get_domain() can return a value.

2. uaccess_save_and_enable() and uaccess_restore() also need to
   become preprocessor macro definitions too.

So, we end up with multiple levels of nested preprocessor macros.
When something goes wrong, the compiler warning/error message is
going to be utterly _horrid_.

Now, as to whether an __attribute__((always_inline)) can or can not
be inlined...

`always_inline'
     Generally, functions are not inlined unless optimization is
     specified.  For functions declared inline, this attribute inlines
     the function even if no optimization level is specified.

Is this another instance of the compiler folk changing the rules of
already documented semantics?  This says nothing about "might not be
inlined if someone passes some random combination of -f flags".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
