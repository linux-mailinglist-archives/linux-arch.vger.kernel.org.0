Return-Path: <linux-arch+bounces-2904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C81876E04
	for <lists+linux-arch@lfdr.de>; Sat,  9 Mar 2024 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F71C21E96
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F843BBEE;
	Fri,  8 Mar 2024 23:53:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B623769;
	Fri,  8 Mar 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941989; cv=none; b=mEsCvpZO/xGxHdy54eTcpxT9qN8sraMn1Cs5lZa2/8ykPFAEnWsbN0vaJ4NVgCLfDdBJrQ3XLOhMw+GMDe0L/TbOy0zeJqm+0/9WcaSaZ1Awhkw+Cr0hTZIA8UL7sKRoRqAcE6o4r9C73S2AkZZihEBDMBq2KLptrv2Dd0YqGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941989; c=relaxed/simple;
	bh=t8OA91R3kyR2UyyWnJ2g3tEc5o5p3PwzgyzGpkHmokU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuRbDiUIYOX9Ps5JO0FjehJ4zPdugp8aTf8K/m6oyjM6S2WQUwVl/kUL/0q8H5Ukmvoh80xREkX/kqRlGMF+XSh/io0VmBSMorI8EidpOe+hBCEPAGmH/ScPieA/V0oynobYsWOds2zoJ0fo2pn2TxpywcGJqB46QDnvzD1roYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2154395a12.3;
        Fri, 08 Mar 2024 15:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709941988; x=1710546788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAaAtnWUg1rxpdk1BKsVfiXox0rISjedblr07JGTkYA=;
        b=IDgKU9tNmT0Ao7TVwJZGynHeYEsQpbEvgk4C9AZk7O4NcxU4TH8sVaWgwdN3ErLqw8
         jjUm3TvSX97sHxUhZVFcCjS1b4j70K3nmVhUdW6Jj1N8YxdHsLOAktGTT8cY3rylMyPh
         BowQ74/w7Zk5C9/7c9tTHsRXrDfIvq9N5AsNdDmqiG9VYkNIOdyMTTupcD/lxEDuYv3y
         K5WsVXWRwCWYcrFoJ0rY4NHHMREN7l0MQOR4dvq/am4LTbrHhTppn5xNXWB2qx/qoXXy
         c+/fiSHE/1Cf8fxnFMSol/DYUReKP1YbhkCeY3P2Glao0GYQQoC7pm+Pv5ohqJWEVsto
         cglg==
X-Forwarded-Encrypted: i=1; AJvYcCWP5TAuy+NeQ7TRVXuav/21idlIT6CnYpEOErjLOcFpCz0AJtWxZi+gc0yROTwEubM+Uiaa5aDmAZp3wKlvi0fGEbQkfAVE48Cs7onUEy4L7Ut8uLlFbSrgAgDUMjZNffV2d9LP5vJt236C3SVWUDc3h2R5jhYDmSGEi5W6IhNqcSFvN92LhQ==
X-Gm-Message-State: AOJu0YyiqhcnNIaHFNMjMAKXdaQ/e+ezStIt1XfcMgEqecgdvBhfOC1Y
	fGXxFllgO7smG6vspWyDpyJ3JfaIzwrNhoqK4hHaNTHJU9yCLM96
X-Google-Smtp-Source: AGHT+IF+FeulvTo1o6BjAN2xTdMb8Ul/K+KciGeAVDA7XkD632jeGsz0rIvfuwgHV41dXl5zLmsguw==
X-Received: by 2002:a05:6a20:3424:b0:1a1:2fda:e785 with SMTP id i36-20020a056a20342400b001a12fdae785mr223595pzd.23.1709941987631;
        Fri, 08 Mar 2024 15:53:07 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id u9-20020a62d449000000b006e57a3bf0e9sm263058pfl.82.2024.03.08.15.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 15:53:07 -0800 (PST)
Date: Fri, 8 Mar 2024 23:53:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: Re: [PATCH 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random
 number generator
Message-ID: <Zeuk3ixlvMFg1CDo@liuwe-devbox-debian-v2>
References: <20240122160003.348521-1-mhklinux@outlook.com>
 <SN6PR02MB4157B61CA09C0DAF0BB994E1D4212@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B61CA09C0DAF0BB994E1D4212@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Mar 06, 2024 at 05:43:41PM +0000, Michael Kelley wrote:
> From: wei.liu@kernel.org @ 2024-03-04  6:57 UTC
> > 
> > > +void __init ms_hyperv_late_init(void)
> > > +{
> > > +	struct acpi_table_header *header;
> > > +	acpi_status status;
> > > +	u8 *randomdata;
> > > +	u32 length, i;
> > > +
> > > +	/*
> > > +	 * Seed the Linux random number generator with entropy provided by
> > > +	 * the Hyper-V host in ACPI table OEM0.  It would be nice to do this
> > > +	 * even earlier in ms_hyperv_init_platform(), but the ACPI subsystem
> > > +	 * isn't set up at that point. Skip if booted via EFI as generic EFI
> > > +	 * code has already done some seeding using the EFI RNG protocol.
> > > +	 */
> > > +	if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> > > +		return;
> > > +
> > > +	status = acpi_get_table("OEM0", 0, &header);
> > > +	if (ACPI_FAILURE(status) || !header) {
> > > +		pr_info("Hyper-V: ACPI table OEM0 not found\n");
> > 
> > I would like this to be a pr_debug() instead of pr_info(), considering
> > using the negative case may cause users to think not having this table
> > can be problematic.
> > 
> > Alternatively, we can remove this message here, and then ...
> > 
> > > +		return;
> > > +	}
> > > +
> > 
> > ... add a pr_debug() here to indicate that the table was found.
> > 
> > 	pr_info("Hyper-V: Seeding randomness with data from ACPI table OEM0\n");
> 
> You wrote the code as "pr_info()" but your comment suggests "pr_debug()".
> I'm assuming pr_debug() is better because we don't really need any output

Yes, I meant to use pr_debug() here. Sorry for the confusion. The
pr_info() was a c&p error.

Thanks,
Wei.

