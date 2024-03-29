Return-Path: <linux-arch+bounces-3308-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3489131A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 06:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69B71C227DF
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A03B79F;
	Fri, 29 Mar 2024 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="F1YDiwD5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9B381AC
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711689201; cv=none; b=F357oeGind+0VJQAVFJs5Q/4qV1mN8Fb/XpWU4qSoP/d5y61DYEUFlhvK+tFM70SKzyWKId6HWEGaGhQYHMt2UlWesiUtov7Sl3sUJ5XPHyw1T4cWsEX59mzgYOJ++tk3wpU+rZLvEmnp8I7xtUzJzDP6Th0egZpuRKAl3wj+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711689201; c=relaxed/simple;
	bh=8Fkz6BkRQSRCyX3LV97sDuqjWeqMtrS+J4i9MTg0akY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bev+luJHqi/ODmie6GBKAvZz1qLNJzeP+VXvpRKk35/YftAfjHVJQhmZf52BQAj1Sf1tXfkJRh4gaA465t2O7L7bFGXemqr8mrfgr1AFmhxSQ9eUq3vyqAKBOjJHJeEbdMYBkGpoug2G5BulowYa2WIQhUcf/UCvwFNNMrdDp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=F1YDiwD5; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609f1f97864so19175977b3.0
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711689199; x=1712293999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEpiqzPowyn+Jm6DRSZLkzq3QJrNEIFqLCLs1kU8rzI=;
        b=F1YDiwD5lxQGc3plCn7FJpGpj5r3ljpV2a1rdi0KO8yixWvEh4woADJCeL4SQKTBN3
         BdSxEIgct6O3/iT/uxd6qxpzoFS7d+qQWp3VmZ1dQqLZcUHOCVPf9S8Y2yuTLzDaAise
         fKZO+yIRRXsDkYggUYWTKsfzafW7j7pWJtDHdd2kg7A5QV93iEiGWtJFcddzbStuG/D6
         ZkYcvZDRfatHOSmpfyFVMvgnGLhrvaGOJKh9RZflNxwUXzTOLblozvq2XJ9pnw2AZiPU
         Q6Y83eDNN/IkNJbsUNi3kYxolP2pLDSE0Nqwqrs5iTjdjp/85Od8I+InbsP59FIDbV6h
         74mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711689199; x=1712293999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEpiqzPowyn+Jm6DRSZLkzq3QJrNEIFqLCLs1kU8rzI=;
        b=sMsV2zwYJ1esuJFCzG1PKpLX4Z6BNmQAVMevRmW1D+SVciIQEwWtddBKup1i1JnyPD
         iefFWufaSo0DnSDOEYEOBeIoEfBbnBvuv5MApwrv0tAaDkMEeqYbq9TC54sGPUIgg0/7
         0Z42JqxeO8Dw9kLbovAhFptVksrM0GxESYXaTmoGo0FuK0ZO23xxLHUr2GPCrvSWRYOa
         C/ntwx5MLWgONDjpp+gWJeQFeoGn3a4Ip/SEMLjDmUYi8biUtCWkLgGowUJ3pbteytDg
         FNzP8lrO4rIWC95V+ZdaxWRtEBUogF4HzXrI71VBpgpbDkgudPJY65YF5hJ9aX4W8k8R
         a8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt10hrIm7uWdyYxsRl5rtfk08y/AqJ+W79/okITdiYuPAm3353zssjM1OnARbivjI9JAIpu3y3O0ZDlNJcqV7BiwgSGbSq1I0R5A==
X-Gm-Message-State: AOJu0YxndcWho1YLeKzAYs+4uXz7hYGKYgK3vN5fuhTxKFSMj4Z1RkPo
	Nu4/tvvPChq5rrHFEr/vcY5886wxl3XS5nB4WpUQDMZtNWI23QHSLqAvhAggfpOQq905N5HuwyI
	NvTR+HRRecrqMRy6kPQaJAt7284cN7VOVNLNPBQ==
X-Google-Smtp-Source: AGHT+IGLN1PwyHLJ6g5mp0jviCkkSbilJ2aTqCWRuUmI56Q5uig7YiHN4eVYWaPbzCmiulMFdD5ghgamQ1GUIWIMF2U=
X-Received: by 2002:a0d:d78f:0:b0:610:e46c:18f6 with SMTP id
 z137-20020a0dd78f000000b00610e46c18f6mr1641447ywd.17.1711689198756; Thu, 28
 Mar 2024 22:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329044459.3990638-1-debug@rivosinc.com> <20240329044459.3990638-5-debug@rivosinc.com>
 <e7b0aea6-c03b-4e8b-872a-8f0299ed6467@app.fastmail.com>
In-Reply-To: <e7b0aea6-c03b-4e8b-872a-8f0299ed6467@app.fastmail.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 28 Mar 2024 22:13:09 -0700
Message-ID: <CAKC1njRaqW9S4moZ-GuCmRw2YO3S_uYO_byNVYarB2yFcn9zMw@mail.gmail.com>
Subject: Re: [PATCH v2 04/27] riscv: zicfiss/zicfilp enumeration
To: "Stefan O'Rear" <sorear@fastmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Mark Brown <broonie@kernel.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
	"kito.cheng@sifive.com" <kito.cheng@sifive.com>, Kees Cook <keescook@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Atish Patra <atishp@atishpatra.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, palmer@sifive.com, 
	Conor Dooley <conor@kernel.org>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	tech-j-ext@lists.risc-v.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, oleg@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andy Chiu <andy.chiu@sifive.com>, jerry.shih@sifive.com, hankuan.chen@sifive.com, 
	greentime.hu@sifive.com, Evan Green <evan@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, Samuel Ortiz <sameo@rivosinc.com>, shikemeng@huaweicloud.com, 
	willy@infradead.org, Vincent Chen <vincent.chen@sifive.com>, guoren <guoren@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, songshuaishuai@tinylab.org, 
	Greg Ungerer <gerg@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Baoquan He <bhe@redhat.com>, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, Yangyu Chen <cyy@cyyself.name>, maskray@google.com, 
	ancientmodern4@gmail.com, mathis.salmen@matsal.de, 
	yunhui cui <cuiyunhui@bytedance.com>, bgray@linux.ibm.com, mpe@ellerman.id.au, 
	baruch@tkos.co.il, Alejandro Colomar <alx@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, revest@chromium.org, josh@joshtriplett.org, 
	shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org, 
	jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> >
> > +        - const: zicfilp
> > +          description:
> > +            The standard Zicfilp extension for enforcing forward edge
> > control-flow
> > +            integrity as ratified in commit 0036ff2 of riscv-cfi.
> > +
> > +        - const: zicfiss
> > +          description:
> > +            The standard Zicfiss extension for enforcing backward edge
> > control-flow
> > +            integrity as ratified in commit 0036ff2 of riscv-cfi.
> > +
>
> Neither of these extensions is currently ratified (the public review
> period started 15 hours ago) and the git hashes are unlikely to be
> correct for the ratified version.

Noted will fix the text in the next series.

>
> -s
>
> >          - const: zicntr
> >            description:

