Return-Path: <linux-arch+bounces-13811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FABAECC7
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 01:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF00E162710
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 23:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A552773E2;
	Tue, 30 Sep 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NwodKnn3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC12512F5
	for <linux-arch@vger.kernel.org>; Tue, 30 Sep 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276127; cv=none; b=O+bLTLUR9rIeZ1iuQen7G9eKJSfNunHNLutW8prQ6DRtyY0g3WjSsnx1oHCHx6XL2YdeNZa8iLWzlxJut9GNksipCU7A/nBgbrgHbP1xmkFhR3AwdEGBW329PHYkNfucAWeY1IzRfx+xbNSiuyTYffPJzI9FMvY1lDXQ2qJAMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276127; c=relaxed/simple;
	bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geDGUtLPuaCOo9Sy5UmUj9NX5B6U/ReZIU5VV2vs3RMWKDOsKs32nQ0R4EPsEmRwa4YJuWD2Y7LwPOIf1B13qby8RDoiV5aF+H8w3EY6Injj1i2YVPU5O3lepHjR1tCG99m5/o95uwVlHU8KbXoWojzJiblRvuo9cMkjo1PAAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NwodKnn3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b55640a2e33so5118057a12.2
        for <linux-arch@vger.kernel.org>; Tue, 30 Sep 2025 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759276125; x=1759880925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
        b=NwodKnn39OQecdVF6d8bOQQDGJ3Gwu3/er8rraGYUv3SuTXqM7jJoNUUTX1ncfQeNO
         aVL4BoTscyDkvFc/witRmX7H6DznBmneHqFSGq3Gw/pALqTtgcSRSchoeu47dGxoazx1
         vqzpdHAOZHplVP0PIE4cJJloFy+YxjIo6e6/dS1lqIhFdxN4cJggB67Lvl3YcPYVKqIO
         t9iibATEJDpJ6slDDzqH5n/R/L9p/WJP9toJHOK5HynjH+6rGAsd3nQ7A2Dn0wRPOdoJ
         ivtTlLJXlIqfICiwwgqY4RDnnVBPjUZkF97UFWMXLGl4JJCZRaYbJ1HTv2rAzyPZyCdN
         B3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276125; x=1759880925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
        b=icHb1anPxwIrCFh2i9tLjDkz+LNjwKTc1pHW7HwqXg7bQtY+B0EWTvHnNa2xSr+rue
         KSgi2a+FCPaVUjWUgzMus+6MSEmLbnSu8H6D0NGuvJs7RTHtsod4qpJjPLWfsD7dGOdg
         VD+gUQILQFERyk6wh6VEgVKAwg2LFHr8+DHjCf+w/Won3W+iTRkiM5WC2jJKH5ABXjir
         GaiixHcy5LRyUauLqc92ydORUrLbsLWKUwlgcq9jMe+SnV/DD9Z5HzUZyoifVepUR67m
         PnSl3zxIuI4SCaZckL6VWRDSvnn2/Ir1H+TFCZta9aDYSnWtgEdB5BE+TXCzlvhvjoIP
         elwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVbpp5iVf9QDV/aJhYZuvTr/h0iADC9g4SaJrKTnOLFd+Rk2bYwH/aqyNNHOEo1Q6rPOvgrIDHNhkM@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXqG9iusPBfgROrjgJaMfKOJVx+dPYUhMRxQtTPL7Rd+5s/K1
	kgPcgbHfV1VdUaMd8J2Pi6CpIqGt6KTQHvguuIibUP8rUM+AgXT1xV8ANYk3oy692HM=
X-Gm-Gg: ASbGncud0LZzrg+wM+/mw4eVnpqR28hFUEuJEmNPCEa+03b90s+1fQV8CXHoSVXz3+r
	Lbeegh4kChPu+IRS+heGDCntS4JCZzlZzPcAl4hQjMQ+qUAO4ZuOJybR24/FUM2yHESsbGKKzdO
	zf6tyfdTTY8d/SpcPks0wkE+la8rtuwBzHiu08WqDy3glahK3al1SFE7p5EJ68pNITOGHPIMxIL
	KbM1E+/hhWa0/psvhEetG9TD8cQ7sYM5ebd9lXZ6wBfYAG4Jr+NloFbEfifHdX2XGsmsGrf7DNo
	oDz5/shbzsoamQw6h4f5xd5zcUPvkjkAvEst/w3cmnB77N7mNjd7tJ4JXCLFyQY6hb8Gj229+1V
	skqb60fRw08zXhTTxECyjSN9m/ih8kwskTnYM3QeHzoMGaEuXfCBIsHP6
X-Google-Smtp-Source: AGHT+IHuRRsekWNjgE7yCPLG9pq3eS/GOyyUhj/f2Q9rAEjbYAirvs/e72q2qhgNkEK8PrNvRevQ9g==
X-Received: by 2002:a17:903:3d06:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-28e7f291db3mr15309515ad.14.1759276125338;
        Tue, 30 Sep 2025 16:48:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882133sm171972415ad.89.2025.09.30.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:48:44 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:48:41 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>, pjw@kernel.org,
	Liam.Howlett@oracle.com, a.hindborg@kernel.org,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,
	alexghiti@rivosinc.com, aliceryhl@google.com,
	alistair.francis@wdc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, atishp@rivosinc.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bp@alien8.de, brauner@kernel.org,
	broonie@kernel.org, charlie@rivosinc.com, cleger@rivosinc.com,
	conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@redhat.com,
	devicetree@vger.kernel.org, ebiederm@xmission.com,
	evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
	jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
	kito.cheng@sifive.com, krzk+dt@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org,
	oleg@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peterz@infradead.org, richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com, robh@kernel.org,
	rust-for-linux@vger.kernel.org, samitolvanen@google.com,
	shuah@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
	vbabka@suse.cz, x86@kernel.org, zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNxsWYYnj22G5xuX@debug.ba.rivosinc.com>
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <20250926192919.349578-1-cmirabil@redhat.com>
 <aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
 <CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
 <aNcAela5tln5KTUI@debug.ba.rivosinc.com>
 <lhu3484i9en.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <lhu3484i9en.fsf@oldenburg.str.redhat.com>

On Tue, Sep 30, 2025 at 11:20:32AM +0200, Florian Weimer wrote:
>* Deepak Gupta:
>
>> In case of shadow stack, it similar situation. If enabled compiler
>> decides to insert sspush and sspopchk. They necessarily won't be
>> prologue or epilogue but somewhere in function body as deemed fit by
>> compiler, thus increasing the complexity of runtime patching.
>>
>> More so, here are wishing for kernel to do this patching for usermode
>> vDSO when there is no guarantee of such of rest of usermode (which if
>> was compiled with shadow stack would have faulted before vDSO's
>> sspush/sspopchk if ran on pre-zimop hardware)
>
>I think this capability is desirable so that you can use a distribution
>kernel during CFI userspace bringup.

I didn't get it, can you elaborate more.

Why having kernel carry two vDSO (one with shadow stack and one without) would
be required to for CFI userspace bringup?

If Distro is compiling for RVA23 CONFIG_RISCV_USERCFI has to be selected yes,
kernel can have vDSO with shadow stack. Distro can light this option only when
its compiling entire distro for RVA23.

If distro is not compiling for RVA23, then anyways CONFIG_RISCV_USERCFI is by
default "N". This would simply build vDSO without shadow stack.

>
>Thanks,
>Florian
>

