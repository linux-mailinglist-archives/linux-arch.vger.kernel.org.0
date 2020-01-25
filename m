Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B659314945C
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgAYKeN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 05:34:13 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYKeN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Jan 2020 05:34:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 484XS24lytz9sRf;
        Sat, 25 Jan 2020 21:34:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579948451;
        bh=AJPU8Hs6GFSApjSXAcOPRu/GO9Tc3s9+wbfyn6Clkrk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m6c5oEoKbKQhdcjjPmW9TkV+VkwNGbsJaGAeyyYLSgUf+heWju2xk7X6Ybz1yuZgN
         2U3Tfgap8+AMnLMF5XCvsj7YU61913Rvo0eYQpUKQIOmLP5x/xqAVbNboD90wtkgFD
         0L2EliyejJ1qcY/6lThw9dC64978raDnMgqHsMGcuN4Xw96ikCNghs45GkMOIKgsDN
         BkdCVuROWMZCpqIj6jkobw/5VqAG+uKL/XdhqVqMcbAwTM6QILY4LsZGmvkNFHSXwR
         FmvMEEYsJact3sNOequMRbv3BQr1lE9JnXyOVNPNHw2uQstSG/8a/1qY8ew6BaQBle
         tAqc+igl/dFdw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
In-Reply-To: <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-10-will@kernel.org> <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com> <20200124082637.GZ14914@hirez.programming.kicks-ass.net> <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
Date:   Sat, 25 Jan 2020 21:34:10 +1100
Message-ID: <87tv4jhljx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> On Fri, Jan 24, 2020 at 12:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Thu, Jan 23, 2020 at 10:36:37AM -0800, Nick Desaulniers wrote:
>> > On Thu, Jan 23, 2020 at 7:34 AM Will Deacon <will@kernel.org> wrote:
>> > > It is very rare to see versions of GCC prior to 4.8 being used to build
>> > > the mainline kernel. These old compilers are also know to have codegen
>> > > issues which can lead to silent miscompilation:
>> > >
>> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>> > >
>> > > Raise the minimum GCC version for kernel build to 4.8 and remove some
>> > > tautological Kconfig dependencies as a consequence.
>> > >
>> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
>> >
>> > Thanks for the patch.
>> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> > I wouldn't mind if this patch preceded the earlier one in the series
>> > adding the warning, should the series require a v2 and if folks are
>> > generally ok with bumping the min version.
>>
>> If I hadn't actually read your reply, I would have never spotted that
>> reviewed-by tag, hidden in a blob of text like that.
>>
>> Adding some whitespace before and after, such that it stands out a
>> little more, might avoid such issues.
>
> Ack. Do maintainers have tools for fetching patch series and
> automating collecting Reviewed-by tags, or is it all extremely manual?

Patchwork collects them for you. But not all maintainers use patchwork,
it's a bit new and trendy ;)

cheers
