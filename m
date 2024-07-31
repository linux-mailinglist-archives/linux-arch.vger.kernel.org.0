Return-Path: <linux-arch+bounces-5766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA48942C00
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB81C22EA1
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B1E1AD3E3;
	Wed, 31 Jul 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlxfEDsb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CC1A8C0C;
	Wed, 31 Jul 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422044; cv=none; b=JZ5ZFf8LhH5Uqexu3azHK/kwtG7BE6kXXw2NVyk72Q2fldVphRGNXetn4t2pX264BUvQMGhrwua7D6qYNIs8X8UQgDebDc/6TLkPAYt6I+w0euqsOWnGLahUdiKGXgUSg/NiAYJmIAczfSXRwLCkivBihCB6R9gY8Hz++4+QOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422044; c=relaxed/simple;
	bh=PZzuAyXiUv8r4B/pgnrvblJtFU3x1w1b4ERBRW/6Ueo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwsufFvC/EAHU3m1uZMaD7jS1GNiuLRc7S8WNV3YtzeVvUYvRoo+XDz/+M/NXZ/0UHpcAPs9XPl0SHUjQE7jISVmCJCR/Iql7jpD3mNCB+Ic6UKZjSW2AxLTgexx1g61JhmKP6a0dgyIGA5LHUF508MPgqC6Qw7DzcCo8pF9sIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlxfEDsb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ad02501c3so699227266b.2;
        Wed, 31 Jul 2024 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422041; x=1723026841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIFp8Khg+4GQ8fLs2YKk+HJiIw5dPfegAQ5FPEevMKg=;
        b=DlxfEDsbOwFI9TgKSlMLkaQ8k8VTLqzvgHDrqT1+KBI8plaXKLBaHmy2oKpQLFCPvy
         83V978BZfrapR9I630W0tby9cEvX0GIxb3Pi6Z10QXnP2mzNegzl9e8cXwiEruAAXWlw
         HHafpFMTCyzMbflIPDy2FvE2x3Pg/C67supPo9Fvtg58BdkqtdDwAIz1t7euh8797koK
         BXDB2lhhqTvcbKEW5I8pyrJuP7NMA2i33TS6UmeyqjNiSveQ/qGit19kl2ckRkaRlfZC
         QwZYRK+knMt/l0KFWMj3utluam8FDR+6zmGzxYv4v/sfOyPu21y4v456VUX9DVTzfWJY
         r0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422041; x=1723026841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIFp8Khg+4GQ8fLs2YKk+HJiIw5dPfegAQ5FPEevMKg=;
        b=PE8gsS29fcoX+6VbpXaJm8lNHfBSsyXGMLkLwghBj5TKdhfC+CBFwYUeJU7LeK4dMc
         8XPdfeClfPWQVBvDjjSrQ65+4DukCO8YxjBu/CWaugSDrdWK9YVmhtuZR/rtbcHvhpru
         eLwp2k6S/oO3LOLksQ5wZ4yolx8JA2GMZisna/SRPNnxv9mtBo/LOLYWqhulLw8AZdt+
         RCyNU5plDTxLlCrGS8yMgqWYwGANmOKaluMoIZ40YlWZ6ckxoWuAWOA8zQP4h2RjgyvW
         Ua74gpCpN2BIUQRgqPYzd8g7Nnqn6uJfk46zggTim8J/h2/MeIIlo1vg0TtMNFd39uYL
         V6eg==
X-Forwarded-Encrypted: i=1; AJvYcCWWHa87aNB4obqOPMX9pWTAG69aHHIPatKt9z45D0EqqPLpHTPl/MySqSZtM1YWRuPFMu77mRMHNFAzmz2gsmJu6bYkpoEs+Kn5gNjlGIxf/r6Xn+hzea1baOs1Y4yeAi/3AWoOu+QadOoXHa/6SSEteTmYV/nC8UCKnjGBpZDMFAbxcrq6sRneaJe+9FF5fCLzoUVSmxGAvvGOa0DrACk=
X-Gm-Message-State: AOJu0YxtGaYb/3I/78noPqiNByot98P2sv+BWSanyTTTNRTHNMNVJJE8
	POIt38UJGQMoefLrm41I3wWUy8Fx12tHqSz2IQhjcEb45+CL8bWJ
X-Google-Smtp-Source: AGHT+IEpqCSb1HZgZrXNMIPoeWCsJDQXhX0oT/7sHA7gK0E/DdB+OsIPbj442pW7/EMYL6tZ0sMreg==
X-Received: by 2002:a17:906:c10f:b0:a72:aeff:dfed with SMTP id a640c23a62f3a-a7d400dd249mr1048974566b.53.1722422040620;
        Wed, 31 Jul 2024 03:34:00 -0700 (PDT)
Received: from andrea ([151.76.3.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9046fsm760828166b.147.2024.07.31.03.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:33:59 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:33:54 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	Andrea Parri <andrea@rivosinc.com>
Subject: Re: [PATCH v4 06/13] riscv: Improve zacas fully-ordered cmpxchg()
Message-ID: <ZqoTEk2zMohhog1Z@andrea>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-7-alexghiti@rivosinc.com>
 <20240731-260cce60e1a6cd06670d1b24@orel>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-260cce60e1a6cd06670d1b24@orel>

> >   amocas.X.aqrl   a5,a4,(s1)
> 
> We won't get release semantics if the exchange fails. Does that matter?

Conditional (atomic) RMW operations are unordered/relaxed on failure, so
we should be okay here; cf. e.g. Documentation/atomic_t.txt.

  Andrea

