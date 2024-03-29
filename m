Return-Path: <linux-arch+bounces-3309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0FD89131E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 06:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F71C22739
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0393BB20;
	Fri, 29 Mar 2024 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jpvfRixe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A14381AC
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711689352; cv=none; b=ummr7aSEAFRaDEk52pCrB/dgXiQ1SpuYKryuOXZceivisGBANKFQ3kNV76IOSzxRNsF24tc5F1h17O89+N5BXH5bFQEK18jEUBgYSUbbrpf+CrZbddTOQcRvEFPL0PYIRbMcprWr8zDPo/9HOw1bOvVE8BmoGxADEXyrP5NeUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711689352; c=relaxed/simple;
	bh=SA5bcVE32KgGG5TtTqzFEWB8zyElCwHL0lTeALGfaJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTeJisg+X+5b5E7NVGquYkND5MLNyOAEkAXo7xbxiq/zavcBrDXnHMzEdE4D7GD3dvGWDYFF+oa3EFHW7ripmU9+LmpI5Bq4D9tM3CWTQ0vxieF3tqZIearh/0VAxUEwCbMJyAcamJ1GT4z0uEtgiTw6JAO+ZFp9RCYloxeSM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jpvfRixe; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609f3ca61e0so18214017b3.3
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711689350; x=1712294150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA5bcVE32KgGG5TtTqzFEWB8zyElCwHL0lTeALGfaJE=;
        b=jpvfRixeJ1lib6rBDNJy3VtVIMgHg7aEwv2m+DZQBf+is6lPnAGqroYCRFzmYeAv8s
         fE7KKFwXFJnuedXoGUse6o2OxYHgP2U7iZc5cNFuO9AS8hsTaIO+wxv9nNouQYOzkZv1
         4m7eF2IRCQprDUkTJMIki+D9bYD9yFsMPGZ2IOJKU0Odcn5BwTM7ecViqJnt5D1zN6vr
         LUXAXolN7Rkdo/9Ioldd8ai797kBcHGSLpsVhN+Yi6vvHaTBFhcLrTpWev0qy6DssQ3U
         Qw3jWLgprqRsAT3ZyQTgp3h7VVUFsA0XRLMKltM5ar2fv/3OEXtQ6dsk54QxMG4mwa5b
         OxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711689350; x=1712294150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA5bcVE32KgGG5TtTqzFEWB8zyElCwHL0lTeALGfaJE=;
        b=rZO1TZOJi07o7LY+ezgqUQtVuKzTzIkI5Go3DajvBedZ4jROTYgNxLFX9DWazy35gd
         cAPRclZB83Fq6zJheXiPbHiF6jxtdMqtqvTziisQw2Xiu8tl1Tas5rbqQiCgewcjXltd
         ws8jp/S59JwtgZG0ZFwpznEYS399THsctmtzdK3Lx95IBxXmaMDilQk9sfSg1pjhB1ff
         ieevp2ARs5DZ0F3x4YJ8CzmeDC0HBuY439obFMMz1gtjG5Rlpq/RU2rwGN1xP0Nqm60f
         seLFOMfpIjQYeBl0483V0byzRhjCVcgaARApwFJNyMraTjohmNMfF6VPyRhcttQQXauu
         S+2A==
X-Forwarded-Encrypted: i=1; AJvYcCVLJIjzdCDDIcDArzJXD9AegmPadedKf9rLQHQOM9Ec3b2vVW6hwuIDNdy7tLxASgLIVVz0Gn0cnJ7eL15Bwomh4JZrx8kVVafTZg==
X-Gm-Message-State: AOJu0YyPH6WsXi01k0HNbIk7DhMKGQ5DoKsXq2wt9in3NthYP5QJQ6qU
	vpQePh28Qxyl6yr3m+bdHIsieBkJU3Qd+d2JBq5qiNTNgsfZIkvknmHqoslVsg3Q9LqZ4mxfyeO
	UZdhuG6hP14ixB+33J01JIKEwrelMKeMI3jabHw==
X-Google-Smtp-Source: AGHT+IEKGRQwrWyCqxzJ0SB08UytfQ1UABftg33xsS/BUh/oR9gt6JPV6v/mkEdtL2mGt8izQHtaPErdxwMk9zmhQVo=
X-Received: by 2002:a0d:f184:0:b0:608:5dfc:1336 with SMTP id
 a126-20020a0df184000000b006085dfc1336mr1323243ywf.39.1711689349755; Thu, 28
 Mar 2024 22:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329044459.3990638-1-debug@rivosinc.com> <20240329044459.3990638-12-debug@rivosinc.com>
In-Reply-To: <20240329044459.3990638-12-debug@rivosinc.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 28 Mar 2024 22:15:40 -0700
Message-ID: <CAKC1njTheY9+gRFgiWaA8fG5hiOFXqESz7eGDbhHhDZC7Kignw@mail.gmail.com>
Subject: Re: [PATCH v2 11/27] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
To: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net, tech-j-ext@lists.risc-v.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de, 
	ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org, 
	andy.chiu@sifive.com, jerry.shih@sifive.com, hankuan.chen@sifive.com, 
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com, 
	charlie@rivosinc.com, apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com, 
	willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org, 
	samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org, 
	heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com, 
	cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com, 
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com, 
	mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com, 
	catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org, 
	shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org, 
	jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 9:46=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> pte_mkwrite creates PTEs with WRITE encodings for underlying arch. Underl=
ying
> arch can have two types of writeable mappings. One that can be written us=
ing
> regular store instructions. Another one that can only be written using sp=
ecialized
> store instructions (like shadow stack stores). pte_mkwrite can select wri=
te PTE
> encoding based on VMA range.
>
> On riscv, presence of only VM_WRITE in vma->vm_flags means it's a shadow =
stack.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
> rebase with a30f0ca0fa31cdb2ac3d24b7b5be9e3ae75f4175
>
hmm.. Note to self:
Missed removing this lingering commit message. Will remove it in the
next version.

