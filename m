Return-Path: <linux-arch+bounces-7890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB319995E04
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 05:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A32128426A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217C45027;
	Wed,  9 Oct 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="wa69CmdS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FEA768E1
	for <linux-arch@vger.kernel.org>; Wed,  9 Oct 2024 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728443883; cv=none; b=Z2vPxGn+1jLslJroxVx+ZJOzdBObAMzk+NRy9H0NVgrzKPFN1/Lly+74RAdD4RCdeLbAh8jFD9DiU15+/bCIY+oTi6D+hmlsGCzotK1xqqJJgdFC2K0iU9a38f3Dbmpv5gFirMIvWdElRN17VlIYVjA250Ujd6xgGT20qUy+VoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728443883; c=relaxed/simple;
	bh=qeTeiqxFgtHkrwd4+T1jN4x/0VgEwAW/vhJtPYAJgZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er8DRi//WYG36SzULCKaLBIabChoPfA4udEs4/uaA5D1+PBjVp2vpjcVvk2NttagqnIqMoqLqMPO8gJg7z5uiVwe2iZj4KuiGK9z1qxTcw9nVVkqMPmiSAo3sGCD32nSumpQOb9+GSWrGUAjtWy/sQRX3MHC5Kx2Htpbz/rN/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=wa69CmdS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbc7861373so5998796d6.1
        for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1728443879; x=1729048679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thDgyfP+u4RJkN9ygN4eA5i7zuNDmPDTp6v1MVROO00=;
        b=wa69CmdS+fP1ESd5aPOx58BtaPjiJwFfHFffIKMyKxRf6muMjFyvOT6wRLP7JrQhPt
         CNBkCsBvWbIK5lKoaT0Y3WafBCiTSC9ihiRDkZ3Qr7tfFSx9c6V6aOQwfYqcR1POLgVw
         zKxWJAQPg5TM059dkeD7wA07AY3flsS+9ul6EetWV7be71gLebJ6MRAVJAI56qAdvDR5
         y7mL7cSOrpuXSPnMbYLEPyh/w5gDGeL99tBXMYrqZjBuhxjKAsCK3g08OMJbgnGZBdzj
         JmQauic/fZsSng8X/qQDsYRg0uD0YprcGCvnjyLS2FPC01cfKPLbltwolbXEluxyq7Kl
         JIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728443879; x=1729048679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thDgyfP+u4RJkN9ygN4eA5i7zuNDmPDTp6v1MVROO00=;
        b=benLrNlRmbYaLu0Rw0CW4HuIyFAIPdnVzzfc9w/mgwb6zF5W5P/5sHzulszNbqHDHS
         bKAPnVZdTsDhJKcP2tCFrQ7yNYw4ObIaoorba4kBCpGw7vlE8qPsp+KAgT2x0KDsy8YN
         WLNcjoYFoUGW3nKI3xTCrygo9rJKO2E4jLjgWO4WEhO/PipIV5HSHnaf9q/bFU+MmXWy
         b0B/rQBHevLCvTbmLwLIRzqz436xn2khQKkc9HPzM22OAXuEqknzb7btyi0RTPa9u6sE
         AWrND7aeO0qtXkoNugeIz1I4eUUywpPA+pHV0u7BTtrb0ka56LRcmYfx+9HqQzab2IOR
         6OuA==
X-Forwarded-Encrypted: i=1; AJvYcCV7ISvDUJ6w7H99i9nC/vSwvctBzc9G5ko8W/ckvEJVwuhmOrbRtYjXDzb5oCVspp649r/Ja7Hblxwn@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBXaYsQJ8PKqPEUEKmCTun9pZGo6CpE53HOkKAIHKDeDhIoE6
	C3hcKqFhXQeeGHzTwIywaB1U+kfz+ZTO7a4Y+HrJeRYetjf/DdIVqhqHDgbYmg==
X-Google-Smtp-Source: AGHT+IEhn9w/MP0oB2WKldelhVAKmKiL1d/EbmMPMKgnT2doMp+iZMaSHOVIOpO2jisfYNBEVmkdXg==
X-Received: by 2002:a05:6214:5a04:b0:6cb:99db:bdbf with SMTP id 6a1803df08f44-6cbc95d4684mr18380106d6.43.1728443879197;
        Tue, 08 Oct 2024 20:17:59 -0700 (PDT)
Received: from node0.small1.linux-mcdc-pg0.clemson.cloudlab.us ([130.127.134.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbcaad37f5sm1820886d6.130.2024.10.08.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 20:17:58 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org,
	chuckwolber@gmail.com
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Tue,  8 Oct 2024 22:17:38 -0500
Message-ID: <20241009031738.2851980-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003232938.GA1663252@thelio-3990X>
References: <20241003232938.GA1663252@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-10-03 18:29, Nathan Chancellor wrote:
> ...
>>> I was able to successfully build that same configuration and setup with
>>> my primary workstation, which is much beefier. Unfortunately, the
>>> resulting kernel did not boot with my usual VM testing setup. I will see
>>> if I can narrow down a particular configuration option that causes this
>>> tomorrow because I did a test with defconfig +
>>> CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
>>> option that is not compatible with this? I'll follow up with more
>>> information as I have it.
>>
>> Good to hear that you've run it and thanks for reporting the booting issue.
>> You may send me the config if appropriate and I'll also take a look.
> 
> I seem to have narrowed down it to a few different configurations on top
> of x86_64_defconfig but I will include the full bad configuration as an
> attachment just in case anything else is relevant.
> 
> $ echo 'CONFIG_LLVM_COV_KERNEL=y
> CONFIG_LLVM_COV_PROFILE_ALL=y' >kernel/configs/llvm_cov.config
> 
> $ echo CONFIG_FORTIFY_SOURCE=y >kernel/configs/fortify_source.config
> 
> $ echo CONFIG_AMD_MEM_ENCRYPT=y >arch/x86/configs/amd_mem_encrypt.config
> 

Chuck and I can confirm the issue is reproducible these options, and we
are still looking into it. Thanks for catching this!

> ...
> 
> Another thing I noticed with this series is there is no entries added to
> MAINTAINERS. Who is going to be responsible for maintaining this code?
> 

We are going to add the following as the fifth patch in v3:

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76..55438cb90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13262,6 +13262,12 @@ F:	include/net/llc*
 F:	include/uapi/linux/llc.h
 F:	net/llc/

+LLVM-COV BASED KERNEL PROFILING
+M:	Wentao Zhang <wentaoz5@illinois.edu>
+M:	Chuck Wolber <chuck.wolber@boeing.com>
+S:	Maintained
+F:	kernel/llvm-cov/
+
 LM73 HARDWARE MONITOR DRIVER
 M:	Guillaume Ligneul <guillaume.ligneul@gmail.com>
 L:	linux-hwmon@vger.kernel.org

Other than the booting issue, v3 is ready and being tested locally.

Thanks,
Wentao

> Cheers,
> Nathan

