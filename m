Return-Path: <linux-arch+bounces-3028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C445687F2E5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 23:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80717280E38
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A7B59B64;
	Mon, 18 Mar 2024 22:04:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79A59B55;
	Mon, 18 Mar 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799461; cv=none; b=hj/tcZsvkxYcAYMKSmFdr1HZNTnRcqfLNiM8PzFVp+3mi4mjzUlUqsoGWQVQ7OHzxyzGHtGAZb3ueryvG//B1Vvl6irlAAjhWe4Sh75W1eElmTZGA6CMLkrpc5w7p91puC5BdZt4pun4Cv+ZvFEjooA31dmOEOhU0CE0j+cX4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799461; c=relaxed/simple;
	bh=WTIXNOXlzdT4Teb/HEQkgZAuNkhc5020tsSCt4budLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4PZU92sN6VeSwHS/irn6SgmSD37J25ejpYjspnZEH/B5e5wLyxtNnvKWuyY7UfLoq2EExLSa7euVVo882r2JLcuyylKrgFUMhdPc3REQM54OffBZ6Py51HC/Pb9oTRbvQekfLCwAD4m/KxVB2o7pukU0TLJ2AKqRaz+Eq+AAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b5aa0b52so4077693b3a.3;
        Mon, 18 Mar 2024 15:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710799459; x=1711404259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0GSdXiGW/zq3Br9q2+DZPiIXYMX2ZyTU4EJy2HfFRU=;
        b=Ors3jZgcqG7UijzSkHKYZ/14+Q8YVA6nZXMpWja8+QWZHjyJ0U4aWCvmrptmUVhRtn
         I53SZOythRDRrHhARWRIAqXGOsW7G9B9u2AgB8mNHqu8Af81pSpt31aS7lrqsyHoVGp0
         GumnA5RUaZhl8zPhB9kNGSYP9+FWB2v0zyTeOo+sc1STkWXx+Fis0tvbOA57G0FoM+T1
         yIwJEG7sx0LHFs90Few8UwK8OQ0DqtSAH2Ya0/w9czYjuekyNQz+9+KlFtXYmcAqdn39
         H5rs2tAOoEbLsVl480G39diQZtKviIgUW75g5SnUce1Gb35sn3ZF7fqfC9NUP3ljz5OT
         Z6NA==
X-Forwarded-Encrypted: i=1; AJvYcCX6PTQZAelaJdDkOQP92KPVT6evKipKghmcQQ9D5ooB1BZ0/Fg5vFGzZUe6nVZVvPtiXQfaRt1S3mZxh93Xf+gAMhDjnVrBuMfjWrd+5dDNgXTDKTUmy/omOZAIr4zF9pISaPJ05NTZtBF5pTF/0OVAHVEr0CJ36wgoX2ikLCeJuY6+Y5Vo5w==
X-Gm-Message-State: AOJu0YwYNup3WYINm480H4Js1wW9j+iM0CP/3jQC8ZNG8XZhRLZlhrtX
	B2sLpFkaOpM4pXMDKPBWuHcH3OPXBRHhRywdi8H6KaTd7HIw2MCj
X-Google-Smtp-Source: AGHT+IFyaAzoUZcv6zRD4W+9k/lN3yIjcDJQulKyiQOk8oe+TZSxw2olEE4V7l6Dxsssa6J6PocKEg==
X-Received: by 2002:a05:6a20:d80d:b0:1a3:6fb1:ab25 with SMTP id iv13-20020a056a20d80d00b001a36fb1ab25mr1823400pzb.9.1710799459010;
        Mon, 18 Mar 2024 15:04:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b005c6617b52e6sm7608250pgb.5.2024.03.18.15.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:04:18 -0700 (PDT)
Date: Mon, 18 Mar 2024 22:04:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, tytso@mit.edu, Jason@zx2c4.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Message-ID: <Zfi6XLyGeNarEeBK@liuwe-devbox-debian-v2>
References: <20240318155408.216851-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318155408.216851-1-mhklinux@outlook.com>

On Mon, Mar 18, 2024 at 08:54:08AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> A Hyper-V host provides its guest VMs with entropy in a custom ACPI
> table named "OEM0".  The entropy bits are updated each time Hyper-V
> boots the VM, and are suitable for seeding the Linux guest random
> number generator (rng). See a brief description of OEM0 in [1].
> 
> Generation 2 VMs on Hyper-V use UEFI to boot. Existing EFI code in
> Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
> Via this path, the rng is seeded very early during boot with good
> entropy. The ACPI OEM0 table provided in such VMs is an additional
> source of entropy.
> 
> Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
> doesn't currently get any entropy from the Hyper-V host. While this
> is not fundamentally broken because Linux can generate its own entropy,
> using the Hyper-V host provided entropy would get the rng off to a
> better start and would do so earlier in the boot process.
> 
> Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
> code in Linux take advantage of the OEM0 table to seed the rng. For
> Generation 2 VMs, use the OEM0 table to provide additional entropy
> beyond the EFI_RNG_PROTOCOL. Because the OEM0 table is custom to
> Hyper-V, parse it directly in the Hyper-V code in the Linux kernel
> and use add_bootloader_randomness() to add it to the rng. Once the
> entropy bits are read from OEM0, zero them out in the table so
> they don't appear in /sys/firmware/acpi/tables/OEM0 in the running
> VM. The zero'ing is done out of an abundance of caution to avoid
> potential security risks to the rng. Also set the OEM0 data length
> to zero so a kexec or other subsequent use of the table won't try
> to use the zero'ed bits.
> 
> [1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

Long gave his review in the last version. I assumed he's at least
onboard with the general idea here. Time is tight, so I applied this
patch without waiting for Long's ack again.

Long, if you have objections, please speak up.

