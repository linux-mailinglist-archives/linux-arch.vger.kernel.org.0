Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34723BB4E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfFJRr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 13:47:58 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:59114 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfFJRr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 13:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B+NQK0qQzwriFdGQRKl3qnBuYxHERXIyxTc267JOpl0=; b=ddQy0EE+r/As82BHbGL2enMiF
        +xSkrfjkaTQ0AJxemttV6by74YhcQ50DLiLC1sA3I03bUdF2mNxbHrY1p4ORkTzfe/rv/xfMgzol2
        SI2MK+71N2dyNCMb6kZwrM5MZdJ8KNTla+ziNnIZzH+w52ZzB0PpDi3xi3X39ShZeK5/E=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1haOPC-0004C2-Gt; Mon, 10 Jun 2019 12:48:27 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1haOOY-0003Rh-VS; Mon, 10 Jun 2019 18:47:47 +0100
Date:   Mon, 10 Jun 2019 18:47:46 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Message-ID: <20190610174746.GA13224@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
 <CAK8P3a3EnvkLND2RJdZtEY64PhK5g0sbbuytQro=f0cPur2g9g@mail.gmail.com>
 <bb5253b2-623c-c927-27a2-1d3a2990d20f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5253b2-623c-c927-27a2-1d3a2990d20f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Score: -106.0
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Tue, Jun 04, 2019 at 01:05:40PM +0100, Vincenzo Frascino
    wrote: > On 31/05/2019 09:16, Arnd Bergmann wrote: > > On Thu, May 30, 2019
    at 4:15 PM Vincenzo Frascino > > <vincenzo.frascino@arm.com> wro [...] 
 Content analysis details:   (-106.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -100 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 04, 2019 at 01:05:40PM +0100, Vincenzo Frascino wrote:
> On 31/05/2019 09:16, Arnd Bergmann wrote:
> > On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > 
> >> + * vdso_data will be accessed by 64 bit and compat code at the same time
> >> + * so we should be careful before modifying this structure.
> >> + */
> >> +struct vdso_data {
> >> +       u32                     seq;
> >> +
> >> +       s32                     clock_mode;
> >> +       u64                     cycle_last;
> >> +       u64                     mask;
> >> +       u32                     mult;
> >> +       u32                     shift;
> >> +
> >> +       struct vdso_timestamp   basetime[VDSO_BASES];
> >> +
> >> +       s32                     tz_minuteswest;
> >> +       s32                     tz_dsttime;
> >> +       u32                     hrtimer_res;
> >> +};
> > 
> > The structure contains four padding bytes at the end, which is
> > something we try to avoid, at least if this ends up being used as
> > an ABI. Maybe add "u32 __unused" at the end?
> > 
> 
> Agreed, I will fix this in v7.

Note that this is also necessary to ensure that CLOCK_MONOTONIC_RAW
works in the 32-bit vDSO on x86_64 kernels.

Huw.
