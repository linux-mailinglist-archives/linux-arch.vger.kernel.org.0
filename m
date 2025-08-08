Return-Path: <linux-arch+bounces-13092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE1B1E454
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A30A7AED3F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855E25CC64;
	Fri,  8 Aug 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cvPx8n4T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC125A35A
	for <linux-arch@vger.kernel.org>; Fri,  8 Aug 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641402; cv=none; b=c3BjKjb+Fv8An+LXCaWilo5XdDWz6ZK+ZjlOaoSIGcpNlD0Uk0gBEVANE2hp0yIdgeNFm/Odrj27CdWFz5ofvECI0qNgmPlmp0CkeRjinxuOFiKNRoVXGTIRQOJD2qrZqA9xJL+T39woU4Tm7Otb9MBqI2tGhTWaOlDc3AKOeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641402; c=relaxed/simple;
	bh=bsh/7R5V9XNvtRBgbRptJnuST96CsEj614d/3uw/SME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAAXwt44sO7b4BiDa5fD+tzTReKJGvn+6Vn2FBlG1sh8dPp2+CeHFj4X/UXlt3msqj4xAn1QXAD0AeqNc2HtwUQDnEtIw4V5506XI5XAJfYUhzvM/7DURhOrjaabvaiPxksG5hY4u90peRuxM7FTw2J9/nGsV+ffsfJh6R4w18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cvPx8n4T; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1296736a12.0
        for <linux-arch@vger.kernel.org>; Fri, 08 Aug 2025 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754641399; x=1755246199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqclBjlpReb8Zh2xzaAy1Tthw4Ak4Apujt4wspR+yjo=;
        b=cvPx8n4Ts3zqRUY2xG6AtHoEFC+hNzZ5gHKFw2TMNfy3bMZrzR2d8hpL+kqLbwSmYR
         WQt08ukI6iwh0c7HnzBCxequGbVbH3ag+m2JMvUnAqXZzmRxkDtRxIacrlNlCyXthOUH
         IgzoduBNZj2S3jD5DSUfLv/zUJPROXyNTcLEU5meK8kRSXnpt9FYN8vypJKpbls9GeYI
         JWhE/0YwY8hwXhJggsRr8VCuj9vpNEERGnUvxPn5WjXqo0915MLiSCeLVHUdpmlKIZV7
         vzHWIsMCoZDofevhvGraylyWzfrqJd+KwOaoQU11M1rDPanciQKQbvHVUHKgHOex1zgP
         WGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754641399; x=1755246199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqclBjlpReb8Zh2xzaAy1Tthw4Ak4Apujt4wspR+yjo=;
        b=wyu96gK2FOPTc0EOhYmp09a9XdeRtniJfmdC9c2eIb49Zfkc1gK/BYD7QWo+inzXH0
         tDUZd1VRiHCd/E7uN99yf+gwBrutizt/8CJ7vbfDeieD9gdkSdQqgBvMKbss3aDJsGqs
         qKu8+K4ICbsCK/WGXwIknValVnBO8MOSwt/pzbuCavzjmgIzj3xiK1S9ebJ3ypZRQUg8
         rWFZXc7mEVCpo1io8D0q1Pi2ENzS3Yl4UufL8vvp0SgyurUHW5TTn/KBLP+qhFy0j/s4
         FZCx0d8/8uzOGIrNdUD/tbcw8Vjd5n95LoHCHO09QCi5XGpvdHvAq8+RvHPTxLakr/KC
         SWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpQDNSrVyf4Lhcvj/yDs/w6QPa1j78wFb7g9kxgN1TycSsHKZcYr5xHNNhcrg443qqxJFAR6bHRbZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxKI7z34d5DtdAX0KreLyFwSBexo8bp8PsUWwJN+Qn9h7p8Ty24
	SqPxxrB14dU/qBal44nB4llCop36v1E9vsr/AEz9T7vh2MTU3SaNdrNDZ49b6mEtqKY=
X-Gm-Gg: ASbGncveeA5ojcBXA6w1QRM6sCpp7HAUOMqkxckSMasxlk/WU6hSW+R4CnZB9lG2iyw
	38/jNDXMHnHK4vtK5Qylaw8aWKtYz8WgQO8y8WvQs6qR7tqLHB3vDGjpD2A6sPWwofPXyFQdTIz
	/wae3BwiN5EFCmWT2CqAd8ApZ8s4d255fIUdh0tkyw+1IeZKDvWaOI8fZsC7eoSDoZUaITOAdhz
	bmeev8SfSuh5sQuNBBX/t9d5DxPnclySMkKrVOBoftFrVj51vP3vJcjOwghwGzWKWOcf7QDqC2u
	iSeD/vSFRTrRKckI6sAEQ7wmjt2HBoBhitB+0XuCXb4WddXR/AiPli1GOmJPigu4upuYvY8DGCO
	Lw9UpEqLEev9HNQv4Ublhi6/tOgTEGE9x9y8LEaYhkPY=
X-Google-Smtp-Source: AGHT+IFzkjQpJ+CBSP5FDKaUMlIyJFyzXkrgnGdlTX6xXb/Zh2Ht/mDaf4SC0H4gKEAF5ZgXVLVJMA==
X-Received: by 2002:a17:903:1207:b0:23f:f6ca:6a3 with SMTP id d9443c01a7336-242c2245139mr30852795ad.43.1754641399054;
        Fri, 08 Aug 2025 01:23:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5934sm202807465ad.21.2025.08.08.01.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:23:18 -0700 (PDT)
Date: Fri, 8 Aug 2025 01:23:15 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: patchwork-bot+linux-riscv@kernel.org, linux-riscv@lists.infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
	brauner@kernel.org, peterz@infradead.org, oleg@redhat.com,
	ebiederm@xmission.com, kees@kernel.org, corbet@lwn.net,
	shuah@kernel.org, jannh@google.com, conor+dt@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, lossin@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	zong.li@sifive.com, david@redhat.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aJWz82F21pVTSVJi@debug.ba.rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
 <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>

On Thu, Aug 07, 2025 at 01:28:36PM +0100, Mark Brown wrote:
>On Wed, Aug 06, 2025 at 05:15:37PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
>
>> This series was applied to riscv/linux.git (for-next)
>> by Alexandre Ghiti <alexghiti@rivosinc.com>:
>
>>   - [v19,11/27] riscv/shstk: If needed allocate a new shadow stack on clone
>>     https://git.kernel.org/riscv/c/9c72a71321a6
>>   - [v19,12/27] riscv: Implements arch agnostic shadow stack prctls
>>     https://git.kernel.org/riscv/c/52eff0ab5f8e
>
>Congratulations Deepak!  

Thank you. Happy that its going in.

> Do you have an update for my clone3() shadow
No I don't.

>stack series that I could roll in for when I repost that after the merge
>window, and/or instructions for how to run this stuff for RISC-V on some
>emulated platform?
I would want to write-up instructions. But I don't want you to go through
a lot of hassle of building toolchain and bunch of other stuff.
Let me see how I can make it easy for you. Will report back.

-Deepak



