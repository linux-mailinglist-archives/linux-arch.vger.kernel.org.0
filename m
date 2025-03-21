Return-Path: <linux-arch+bounces-11010-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA2AA6B510
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 08:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB07A5015
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6641EBA0C;
	Fri, 21 Mar 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QQmtMvYU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C91D516F
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542308; cv=none; b=XnqUlZazRg4Tm5LBeuEQFRo3MORM5QRazDY0QM/ZFZPDBNC2ihv9K8ZCmlDsABanO6EHLugnOHv8aASOwna/sBcumd07KKtYuSnrP+TkD8nYleIc4/S+lZVhrM+507+PCsPn0qX5/ZC1akWWVnkEXH/z4AKjVhYyvXjaSGtgVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542308; c=relaxed/simple;
	bh=GdD46RXzLITLcyofqDJ2zWxNrp2LOOXutJPFHpVGBHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TJz8iQDwztAvaa9XTVUCAAEiPXLli+Xeq9bFzdT5dXUUoG2P0H5oWr2ugDI8zgiXNyGPxUv183OgJWVXOoEzLsPBSL307bEyIHxiXyZdi1rp0Fu6btfUpWG3MqWQOZEm1Fo7b+ux+g+CnkAYPYn3cHH7oUYXnCuuqE1qf9kypsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QQmtMvYU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43935d1321aso2143325e9.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742542305; x=1743147105; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA53ZruOOQL6IYeAD91OZdQ4lvT8qFBPlQC4O1CwTT0=;
        b=QQmtMvYU6Q53j6hUeBMHzB4neX/xdvVL0pbT2TDe/5ndgYuMG1xp9WZ2C94YnnB4yO
         pCL9UvOSe10UK3WdwdpwD15BYKaYijADRw//75nfLGm0rtB8amloFZXBoUcVQ/ZMWDKr
         5o5LbeE24PyKNltBklqhUm0aj45cVDdrtbFxYzqU43K5HeMbM0eCD2Lqkf4ZJi82QqmO
         vUrlonj1ubUhaKNdmuk6WclJdvRffA7sN6ABfu3fyqMzJvwnEXKR9Q6/YwgdcENc6hbs
         QTz2K9PW2i0Lwsc2yFHBBL+RyISsYkPzpMV9U4aSHY39+iC85zugSnxTfQmAdYLPzcJq
         CYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542305; x=1743147105;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EA53ZruOOQL6IYeAD91OZdQ4lvT8qFBPlQC4O1CwTT0=;
        b=WotOLfLGlzxhqBwCCcGAVh1q54Hvrtlr9pasL4Bo7DF8daEuKRAllv72UeeKcVrp3O
         vJf5aDsxR4/kdzk13VbDQ9PuYZpKavGkY0jlVSPFuz9pG6FlxBJppjOWzG7R2GA764eI
         X5XDc1bPoXSkVhU4uhFteDgToX4TuRxLVwOSelndtIb7+fp1gi3l3eAlzPfwLUg4R+EX
         eD3r2y6h4+fAI+CNuX9q0tS5O6QctNA171x/50FAwsgxzYJ8yAQ+hZ3lLirCt42RZ2IB
         dvHvYFokD/xDp3LAXjs13ITkLXRYrcYly6N73hQwehProqFzIb9rBbKhzHrHE2XF602I
         hQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVhgMf8QBVEnlDVbCFDCUI6P8UgPj2T64GuUarIKydKa87QOQU9da1TVhKMJj0f00AXQAkIQJ+9p8eU@vger.kernel.org
X-Gm-Message-State: AOJu0YywF1Bpe2dRDlTKvFjj4PScjroewvZvojSlnaCiLpWzmPbN4LPH
	mkYThsHcW7ZTPW6T/kIrJvdp/0+FxKNIxuBigFpb3FiW3Eo/u1XN5ZdpJITXrZs=
X-Gm-Gg: ASbGncskJodVExdSPuay58g0FVVZc4XaOpo3suZUzwP+3hCxSrVoLn9woXTW7DTipWc
	pRLZ//8cCcitw1WVqvy6iyMdGeUY49b8qN+J/L3Py6uSDcoAOnlKoWqUSjHRfxzXqs5u/v0AhbJ
	0/vNM0EOkUcBGoWnd+aZ1lw/RVScMFqHKnUs008bbXNbpGCLoTFvGy1/RmTGm339SGu+oDSP2yE
	HS5xqLo/47pcqu+5GovO/v2wjClCY42GZn8dSg/HR0sQGzORbRNoCStta0seziSDA3IrNk9KwPI
	lixKKyFRJX3HN0x9xNLuR7+NthqZ20eRg3woM1c7hjkWkxkPen+2rjsRFKxNPHjreQ7NnhR5PfF
	Znz4q
X-Google-Smtp-Source: AGHT+IGUPJ1yScRfM5ZckM0YOEUPSKKsLT1uHikzcP6azc7wS+CuSOBN2Ombs1xBV9GpD69REV2V/A==
X-Received: by 2002:a5d:64c7:0:b0:386:3a50:8c52 with SMTP id ffacd0b85a97d-3997f917397mr932780f8f.7.1742542304656;
        Fri, 21 Mar 2025 00:31:44 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b260fsm1585165f8f.43.2025.03.21.00.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 08:31:43 +0100
Message-Id: <D8LROZ1Y2LLF.20T6DQS0A39QN@ventanamicro.com>
Subject: Re: [PATCH v12 23/28] riscv: kernel command line option to opt out
 of user cfi
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-23-e51202b53138@rivosinc.com>
 <D8LF0RDZ6809.1I3MCCVSHRSQ2@ventanamicro.com>
 <CAKC1njQR9yARvWffjznjpeZK5zLFpg0-qCUo25_8niH29YL6uA@mail.gmail.com>
In-Reply-To: <CAKC1njQR9yARvWffjznjpeZK5zLFpg0-qCUo25_8niH29YL6uA@mail.gmail.com>

2025-03-20T15:31:09-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Mar 20, 2025 at 2:35=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>> 2025-03-14T14:39:42-07:00, Deepak Gupta <debug@rivosinc.com>:
>> > +__setup("disable_riscv_usercfi=3D", setup_global_riscv_enable);
>>
>> I'd prefer two command line options instead.
>
> One for zicfilp and one for zicfiss ?

Yes.  I don't want to suggest the naming, because I would have used
"nousercfi" without an argument for the current one.

