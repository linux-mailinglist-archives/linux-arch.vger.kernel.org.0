Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FB4E66B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFUKtM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 06:49:12 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:48330 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUKtM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 06:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j2GzdxnYBK8G7Fj9E5HisiRxVngkkouaD3FQTjun8xw=; b=EGaACgO9PwJhsTSBqdwtLIVr+
        NwMW1810knKUDihDGmTj5uZ9ZTEq9zNnCGvyJyYctDTJ2Slu6pp/Wf534Xz+gL3gyQEN0extj+Ix/
        sH1jTIrlijGT4xbDNd/9OmdmJKxZqATv/EvWUMPh9BPDt+AiJa9AlPMcdQGghjRVCNwpk=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1heH6x-0003kV-6K; Fri, 21 Jun 2019 05:49:40 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1heH6M-0001lJ-SR; Fri, 21 Jun 2019 11:49:03 +0100
Date:   Fri, 21 Jun 2019 11:49:02 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v7 03/25] kernel: Unify update_vsyscall implementation
Message-ID: <20190621104902.GA6646@merlot.physics.ox.ac.uk>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Score: -106.0
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, Jun 21, 2019 at 10:52:30AM +0100, Vincenzo Frascino
    wrote: > diff --git a/kernel/vdso/vsyscall.c b/kernel/vdso/vsyscall.c > new
    file mode 100644 > index 000000000000..d1e8074e3d10 > --- /dev/n [...] 
 Content analysis details:   (-106.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -100 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 10:52:30AM +0100, Vincenzo Frascino wrote:
> diff --git a/kernel/vdso/vsyscall.c b/kernel/vdso/vsyscall.c
> new file mode 100644
> index 000000000000..d1e8074e3d10
> --- /dev/null
> +++ b/kernel/vdso/vsyscall.c
> +static inline void update_vdso_data(struct vdso_data *vdata,
> +				    struct timekeeper *tk)
> +{
> +	struct vdso_timestamp *vdso_ts;
> +	u64 nsec;
> +
> +	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
> +	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
> +	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
> +	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
> +	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
> +	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
> +	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
> +	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
> +
> +	/* CLOCK_REALTIME */
> +	vdso_ts		=  &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];

There's an extraneous space after the '='.  Hopefully Thomas can
fix this up if this patchset is otherwise ok.

> +	vdso_ts->sec	= tk->xtime_sec;
> +	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;

Huw.
