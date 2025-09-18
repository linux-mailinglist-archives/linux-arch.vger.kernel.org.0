Return-Path: <linux-arch+bounces-13684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5314EB86D0C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C65A16F025
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376F31961D;
	Thu, 18 Sep 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f8/8Pko/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4A3195FE;
	Thu, 18 Sep 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225633; cv=none; b=RY0zhn3QOMAU9DgLFpJK6A0nnpX4WcoAiIBFqd9JEa5JzEfl9WT6bpyVKxe7S+MXgAcGTpRFjHHwU5RKGasC+0SeEjKRG27fx/aZUSFE/ySCoVLhLK0yPNU6jmh//MznFQTR9T1YtWQ5Rs5ZpeZhJiUGioAXxwrPIgDqzk/FtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225633; c=relaxed/simple;
	bh=cKo8QnxTqwRlZbbrTi6NfByG+sCorX6sVt0V6y4S1EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5lE5A60+cKKMffogpC1FvqBT/5ogUilC56NCrJoLWo8bde+aLFFSUfJ2jIf6qF4u0k2TZPfnfEf+7n3Jae9juqxkur8ypszZEgO396KDewwX74RdWOJY9Jjnpxt4PlAaa/WqDRLf/D9++GUb0awTPxXr6tXd6r1srAlVCqFWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f8/8Pko/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5CCF40E01B3;
	Thu, 18 Sep 2025 20:00:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1khS_LFk5DMP; Thu, 18 Sep 2025 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758225617; bh=XI8MbpBy+ycWzG5aO02jWHqOsvEkXPBPzx6jQtrzNY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8/8Pko/2jb7mdI3q8FvyM+z/0suyHgNXRse10uugugMJdlXgPLIkaqMRCtvbcdWb
	 C7voUCVa0isP7XjAONjs0of4kM6o934NMivN1P+/rx/WybQkUKDaHtSalg9QODm3H4
	 7o9d5jdyezqh/4V1AGSW06kTODhdRYMHABgf0z39QQVmIbDINovD3O1wStzgYNSYZm
	 V2eBLWTBsuUldNphGqRO7aaIG2UDhWTFQdyBWW51KXfz/CB4cYNAWJZiURSSU3lJeK
	 Xr4BFA7L+btTDiF1tCnMIuM1wKNtqiwBfHpcFrRIK8kDHE1mDODjoUdmm2F0FfVinQ
	 v50OZBWMN6YGRZ+iXCS4EuEg8iMZaxMu22Skhj+flIMyaZBOzXHL28+9i9DNm54gCp
	 TOq5JD9vQq1PoIvV9pKwqyGXMdKO88cwcdiKpmgg46EHXFO415ND02wXllDjoJSURp
	 Xhb4dfwEJisZzzj//t1pvZSv4e/fOCR53YShixh7C2LmnW2Ytuh3TMFx8eoV7eqxZe
	 AImKJZTeWuXtSUffloQRl1ShQYQaiSkR/X5OjSWgMWtXy0lSXkWXoLqggfaXutrxVd
	 BeSg5Op1YtAXo1ipExLr9Z2tGFIHpBDeOJkV9CziBkPuNV3YM//gtJPpoFEJf9b7S+
	 YzHZ+Ca4pOeOLFoBzb1/FrSw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CB88C40E01C9;
	Thu, 18 Sep 2025 19:59:58 +0000 (UTC)
Date: Thu, 18 Sep 2025 21:59:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de, Neeraj.Upadhyay@amd.com, tiala@microsoft.com,
	romank@linux.microsoft.com, linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 5/5] x86/Hyper-V: Add Hyper-V specific hvcall to set
 backing page
Message-ID: <20250918195952.GFaMxkuFc1OqfWavWv@fat_crate.local>
References: <20250918150023.474021-1-tiala@microsoft.com>
 <20250918150023.474021-6-tiala@microsoft.com>
 <20250918150959.GEaMwgx78CGCxjGce8@fat_crate.local>
 <CAMvTesBwkFr7VYoEYq5hc7NJi5xdiz037bmzoaEV2eG__h-kTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMvTesBwkFr7VYoEYq5hc7NJi5xdiz037bmzoaEV2eG__h-kTg@mail.gmail.com>

On Fri, Sep 19, 2025 at 01:11:02AM +0800, Tianyu Lan wrote:
> Could I move the check into savic_register_gpa() or add a stub function
> to check guest runs on Hyper-V  or not and then call associated function
> to register APIC backing page?

You probably should do

static struct apic apic_x2apic_savic_hyperv

and copy the apic_x2apic_savic contents into it and overwrite the .setup
function with your variant.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

