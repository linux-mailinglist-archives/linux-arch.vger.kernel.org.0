Return-Path: <linux-arch+bounces-12626-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D269AFFAD2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 09:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22705A2902
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB8289E2E;
	Thu, 10 Jul 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CcOZGnCI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244028981B
	for <linux-arch@vger.kernel.org>; Thu, 10 Jul 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132434; cv=none; b=fDL1b3yWltEYBNM1jJpgFLNonQioANRuIjkJvR9QJDoKoPT7bsQaZu34KJdPDPC45lLkuCZkDGWSNsZ7MNvXsr10UsNxq83agEnyrGXMz1nbdsZ5dE2aFzn5UMtMYeSKUxsHVjGb7HgLQXao9beazMocXoS3/bSxSWNIesEewZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132434; c=relaxed/simple;
	bh=rGPXOLhW/ZBDbbSbCr7CIPthOkxpIALUagVApnO451Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=c7VSIX7h9e3IIz22EwGEKhnzWkIy7Z0egLz6LTZAPeUaXhT6JbGngEvS1gyJIY97QWnAPmTiE34KefIBUYWBOwrtMYa2cI4Ymn4OBkrFiOFELAe9danqzF9x2zzOf+qoyEl2Qji7vzwzoIJI0Zel4mv2EduYJ1J3iP26OxEp69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CcOZGnCI; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250710072710euoutp02791329d986235a1e0088d15bc2e323b4~Q0ymHckiD2814628146euoutp02I
	for <linux-arch@vger.kernel.org>; Thu, 10 Jul 2025 07:27:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250710072710euoutp02791329d986235a1e0088d15bc2e323b4~Q0ymHckiD2814628146euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752132430;
	bh=oTRMdhpVvZM6ziaWR/olIUECYo38sNOd9KGNsVaVt6E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CcOZGnCIrleveyg8c3rkylM7kODEMB5dkcxXKpnsK3/cQ1kRBQw9dpILw/FQNL9oJ
	 Rm1aIO1o0WVqOaHokijac1CY8O88tWqLgURm4u7q03g5DZ69X1vt8GyKt7XlgIn00M
	 soKB7QH7o1C0LjMpaNIfza92/e0ozGgtdAkaENes=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710072709eucas1p2631d5fe8d35d10f7de05bd5ceb8ce5bd~Q0ylbGids2385423854eucas1p2Z;
	Thu, 10 Jul 2025 07:27:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250710072707eusmtip2c499c55105ba1e1cb1cd664e35fedc38~Q0yj0B6or0472904729eusmtip2T;
	Thu, 10 Jul 2025 07:27:07 +0000 (GMT)
Message-ID: <e0f09c5a-1039-4d16-93c4-ada79929b8e4@samsung.com>
Date: Thu, 10 Jul 2025 09:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdso/gettimeofday: Fix code refactoring
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Vincenzo
	Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Richard Cochran
	<richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt
	<werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, Kurt
	Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
	Tenart <atenart@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250710084337-0c82b93c-85f2-4305-95ba-8cb14042aed2@linutronix.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710072709eucas1p2631d5fe8d35d10f7de05bd5ceb8ce5bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710062301eucas1p1b61431dc31a5933087b45c246866fb17
X-EPHeader: CA
X-CMS-RootMailID: 20250710062301eucas1p1b61431dc31a5933087b45c246866fb17
References: <CGME20250710062301eucas1p1b61431dc31a5933087b45c246866fb17@eucas1p1.samsung.com>
	<20250710062249.3533485-1-m.szyprowski@samsung.com>
	<20250710084337-0c82b93c-85f2-4305-95ba-8cb14042aed2@linutronix.de>

On 10.07.2025 08:45, Thomas Weißschuh wrote:
> On Thu, Jul 10, 2025 at 08:22:49AM +0200, Marek Szyprowski wrote:
>> Commit fcc8e46f768f ("vdso/gettimeofday: Return bool from clock_gettime()
>> helpers") changed the return value from clock_gettime() helpers, but it
>> missed updating the one call to the do_hres() function, what breaks VDSO
>> operation on some of my ARM 32bit based test boards. Fix this.
> Thanks again for the report and fix.
> This change has already been folded into the original commit by tglx.
> It should show up in todays -next tree.

Okay. I got no information about that, so I decided to send a patch just 
in case.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


