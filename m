Return-Path: <linux-arch+bounces-11561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CABA9B036
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68F67ACDAE
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571A17D346;
	Thu, 24 Apr 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqI10tR6"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E118A959
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503792; cv=none; b=euIX4KlF0vCAUROeyt6bTFUryJ1YuXQP+uUPV1mucp7yxoNKxh0LZTkDlJwkYCRaq4JDLns2onqzRIKqw/OgxEUQpVE86KrHvaMoToC6nRLHbmuSWdczMlbeYhQ0VWmB19DZPTkVDgUfG15V8Xno5jF4JuJXWf9B2lOiybiRttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503792; c=relaxed/simple;
	bh=Byl8wGqJTtnl74RJ2YKMT0DDlnonSferfdT8IKzK5+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2ORUVERkJtojOR7FneF1c33zMdukrCu3UbkJgNTunW1rHmaScSA71WfTMpVh5OgB7QIeh0A023tEehCEGmB2zscygElawAYrtOYSaIR6noelj0pulnfZHCW4T9ab56wl5l3KoltegfjZ8sZ4wDlM1laATHEIZySPICwDLJHRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqI10tR6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcd6o2tvUH9Wlq0TU9ZCul/Ej7huhlgPAxSc9bD4eg0=;
	b=gqI10tR6664EVHaUzsi6pGv6tz0HdbE9geKp9ilsJrCv/IGdHdIl3F+t87ZV5iEWJ36BFT
	90ww/K6AwKDagRwpzvjf85EZ5QIlj0H5iBbyf6dpvyMJHbcAUl6S24WnFsa6qAyHGrCAeF
	PakxFVdr+Mlayu7wN0mHe39Alz4ycjw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-gJtlafXoMD-ndlX2r6WFmQ-1; Thu, 24 Apr 2025 10:09:47 -0400
X-MC-Unique: gJtlafXoMD-ndlX2r6WFmQ-1
X-Mimecast-MFC-AGG-ID: gJtlafXoMD-ndlX2r6WFmQ_1745503787
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39d917b1455so340182f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503786; x=1746108586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcd6o2tvUH9Wlq0TU9ZCul/Ej7huhlgPAxSc9bD4eg0=;
        b=P1nVuqyKU2FUnPTp62Jp2/AHWEXlNq5HSlQ/4AGRjI4IhvimMO8NMeyN8JuaNretLq
         VLybxfr17orXiLE910Fbjrfas3+kjE2VEx+koBqGMC/W/MDb6QGgrWw12jbm+LVanAJE
         ED3PatWIZQ7LzCQMAvId/X3P/MFNFthemkV/DdFgpRX5Sb9YZXMaOUcuXesEbhT3sGKB
         x/w8ueXetSChIxT2sTyxn7auUMcmg44iyH2ncwhWkiExRTDD6jqAK9loSoehgHEkOWSc
         3LeiLxeEgDodvXYbvTJ0ZTR+Fs7FoJBJAmEaAJLMu5AXLZfVASLi6vN++mF+IK0r5XWo
         XVmg==
X-Forwarded-Encrypted: i=1; AJvYcCUnEkLuf/45UCNZi/CKIrWCjC8C5Yjiic2rHdpHgZ1soV5EVdKhT2Ix3CmQRyKZrhp6B9oErqiMzfFS@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBbawC4OWenI/bpg4NHotuRBspdrFz/6NjAdVpNXkvYqzxfB7
	lFV5I4IG6ofEcb0sY2XctGYO0DueI/4Qm/pnAxLbVTdML6rBqW862IR2CSHIUMVae8qPhFjr4CA
	svVjjUQ/R+X4lYLuWn7Bpxws8trxRJ9LuNOWGAGu5Zs1esAxUhxXPSapF25A=
X-Gm-Gg: ASbGncsLOoiIxn+YpNDjg9PwPhcQk099/n8g7SkzW7YOGRLaEMWa8N2bWgd5HjCHD1L
	MuQhpUXzQuSbM1cRNX6/CqbFdE6r8ZVS8X71eZQiVU2NREhY2HGENNSkKZNmBswrvOqTpqCjW/C
	Ssml8z+5iZPu5XpPeHTktvLH0hPU4SHp4+QJNCm9NtM5glIR0sz1PVj2uUvdfuItWzGN/79io9k
	/XHiVaYSgbxpCidpA/NQfhfkKlT0Qe+ZgMCmpARihu1W814zwYM5eWuJyUkCwWmz3EgopVp6nXV
	pAefIp3jgzEzO9BzSVFtisKSqw==
X-Received: by 2002:a05:6000:40dd:b0:39c:2669:d786 with SMTP id ffacd0b85a97d-3a06cf564f6mr2030207f8f.19.1745503786432;
        Thu, 24 Apr 2025 07:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCLnvnPrTr2kA4EPsTX8eBJWla0qlNHBLrDC/aXaOPuzLScpVQ0iwMUi89EkItUdIH45LJew==
X-Received: by 2002:a05:6000:40dd:b0:39c:2669:d786 with SMTP id ffacd0b85a97d-3a06cf564f6mr2030125f8f.19.1745503785858;
        Thu, 24 Apr 2025 07:09:45 -0700 (PDT)
Received: from t14ultra (109-81-82-22.rct.o2.cz. [109.81.82.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c4945sm2217236f8f.47.2025.04.24.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:09:44 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:10:04 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	jstancek@redhat.com
Subject: Re: [PATCH 08/19] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
Message-ID: <aApGPAoctq_eoE2g@t14ultra>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
 <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>

On Mon, Mar 03, 2025 at 12:11:10PM +0100, Thomas Weiﬂschuh wrote:
>From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
>To support multiple PTP clocks, the VDSO data structure needs to be
>reworked. All clock specific data will end up in struct vdso_clock and in
>struct vdso_time_data there will be array of it. By now, vdso_clock is
>simply a define which maps vdso_clock to vdso_time_data.
>
>Prepare for the rework of these structures by adding struct vdso_clock
>pointer argument to do_hres_timens(), and replace the struct vdso_time_data
>pointer with the new pointer arugment whenever applicable.
>
>No functional change.
>
>Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>Signed-off-by: Nam Cao <namcao@linutronix.de>
>Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
>---
> lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
> 1 file changed, 18 insertions(+), 17 deletions(-)
>

Hi,

starting with this patch, I'm seeing user-space crashes when using clock_gettime():
   BAD  -> 83a2a6b8cfc5 vdso/gettimeofday: Prepare do_hres_timens() for introduction of struct vdso_clock
   GOOD -> 64c3613ce31a vdso/gettimeofday: Prepare do_hres() for introduction of struct vdso_clock

It appears to be unique to aarch64 with 64k pages, and can be reproduced with
LTP clock_gettime03 [1]:
   command: clock_gettime03 
   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
   tst_test.c:1903: TINFO: LTP version: 20250130-231-gd02c2aea3
   tst_test.c:1907: TINFO: Tested kernel: 6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k #1 SMP PREEMPT_DYNAMIC Wed Apr 23 23:23:54 UTC 2025 aarch64
   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
   tst_test.c:1720: TINFO: Overall timeout per run is 0h 05m 24s
   clock_gettime03.c:121: TINFO: Testing variant: vDSO or syscall with libc spec
   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct 10000ms
   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct 10000ms
   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct -10000ms
   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct -10000ms
   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
   tst_test.c:438: TBROK: Child (233649) killed by signal SIGSEGV

or with:
--------------------- 8< ----------------------
#define _GNU_SOURCE
#include <sched.h>
#include <time.h>
#include <unistd.h>                                                                                                                                                                                                                          #include <sys/wait.h>

int main(void)
{
         struct timespec tp;
         pid_t child;
         int status;

         unshare(CLONE_NEWTIME);

         child = fork();
         if (child == 0) {
                 clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
         }

         wait(&status);
         return status;
}

# ./a.out ; echo $?
139
--------------------- >8 ----------------------

RPMs and configs can be found at Fedora koji, latest build is at [2] (look for kernel-64k).

Regards,
Jan

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
[2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2704401


