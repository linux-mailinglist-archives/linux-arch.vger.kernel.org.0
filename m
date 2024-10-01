Return-Path: <linux-arch+bounces-7568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7098C7C0
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 23:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939FC1F25861
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530091CEAA0;
	Tue,  1 Oct 2024 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S2K2WldV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE41CBEB0
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819205; cv=none; b=E97Tl22ZYjdpwc3gj0Fb5nqrQRYk3Gp+hSDMQLaHD9+lg66f7Vtp15qUvt6AGdQEO63WHZztPw0vvQbfIPKfAV361FdS/DujTqFfWhSHJZrgziBpmBcRsViZ2ealQkcLhQEXU1EfK4N6GzIlHzkC7K3a/l1OHlDfrdOv4wGHbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819205; c=relaxed/simple;
	bh=NI7gIZ6lXNALBDXx17GTUYrDqDSXsA596QRPsZyrdEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZtU5tgULyxta+i579t20grCgy8FAgHw29LaCdyGZrneThbU/7ASSZOYmtTYEpehvj760ziuhBpv/3LtzceSJQYQfe7CTeGP4SxeaYWs2M4EcTH/0FfubsP/aJaJr/Bp2nsNGIs4WxsaTLmfkt0Fg1zp7yAWQ8kvcAuBUkuRhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S2K2WldV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20bc506347dso3783875ad.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727819203; x=1728424003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NI7gIZ6lXNALBDXx17GTUYrDqDSXsA596QRPsZyrdEQ=;
        b=S2K2WldV/2rdo2FVApspxAietHKRorS5wt505eSfc5CKZU9aCRhGC4cm0ILVinpbuR
         DowrIM4BkIk5B3syO4isXBuMeVkbMjqeQNfE7aKt5CQQgchNWVqd6CD2Sp/HsnkYfHQH
         3ldcMBBgwvaOZnfcNsq46hRhmxQ743dqB0J1c2kIQDGan7B7l/OTLoSHp5K1ikS+KyoD
         Fmt+av5uXOMnOJU5+rBh4HV32QqgIbGsEflb7voMfTtexVt4vQzpfTXx7+cKlpnUnPyQ
         yvBmf8pseDCX7H7w5RCm83pPev1svT2Szbdns1rQhgMtubqUKEWHUiQf3ZY0wdUy/FQG
         eDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819203; x=1728424003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI7gIZ6lXNALBDXx17GTUYrDqDSXsA596QRPsZyrdEQ=;
        b=O0JQPmeqDq4ozVB48fmqGTBUAtllfoImjKcEggUif0GX9BhckjydkXsbxWY6/rGtKj
         O11H/sI6rLkt5i9u6dQyNq0kI7V7PLTiqW68CqF8tQ/AArNtxI5lhGiMVYfAwwXew8qI
         hdduAiloBZ3VQQrqj7c08AWMaklLThiuqLb6WfUQ0czsiNFUQuITytWHf2pessW1oLiC
         +hqX359dXQHa9+COALzaJcQMXCs43hEVkMZgZIUnlH/PqK7vjFgJF5HKs98vORRLzglr
         6N4WYTz2iluqyADRC4l1CYj6gZaaLeN3TesJT80KL2TCENGqeCUsJ2FRA9YAMRAc4hbQ
         ojaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnvd1lpgRIwtmnKEyqsQLCxsRgHt33FOW05hlSZJOkDQdGmBscSFAY/I3QL0gVfQ0ayc56jyd2T1yY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64OGwZDuXUpUyd/+RStEY4mSFP1ppE2+xPFQKpQPXlDPdYnI1
	cKE+izZHWAWqDHtm0/21LViX5vw6NnkKMyghtYO2aSmywsSWuqY5bYAsvg+lvow=
X-Google-Smtp-Source: AGHT+IHZV3IXCvzX283Z6okxtWKNux4YPD3i7IwxnTn7aGOH5zQYuUZMEM+naOwP+vJ3UKzd1e3dgQ==
X-Received: by 2002:a17:902:e743:b0:20b:7ed8:3990 with SMTP id d9443c01a7336-20bc59bc4cbmr14154355ad.12.1727819203103;
        Tue, 01 Oct 2024 14:46:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61c4csm74275315ad.274.2024.10.01.14.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:46:42 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:46:39 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH 17/33] prctl: arch-agnostic prctl for shadow stack
Message-ID: <ZvxtvxMwFvjgengs@debug.ba.rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-17-3ba65b6e550f@rivosinc.com>
 <e7c48ad8-5fe2-46d8-b137-e04046b7c572@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e7c48ad8-5fe2-46d8-b137-e04046b7c572@sirena.org.uk>

On Tue, Oct 01, 2024 at 05:15:08PM +0100, Mark Brown wrote:
>On Tue, Oct 01, 2024 at 09:06:22AM -0700, Deepak Gupta wrote:
>> From: Mark Brown <broonie@kernel.org>
>
>> This is based on a patch originally written by Deepak Gupta but later
>> modified by Mark Brown for arm's GCS patch series.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Co-developed-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>
>You need to add your own signoff to this when reposting, see
>submitting-patches.rst.

Thanks. Will do that.




