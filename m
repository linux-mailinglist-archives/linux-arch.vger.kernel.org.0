Return-Path: <linux-arch+bounces-3720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F218A6739
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6941C21527
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078385948;
	Tue, 16 Apr 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY0PfPTE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7D2745D;
	Tue, 16 Apr 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260186; cv=none; b=Nax/Ub7MFbR0l3URmcZs+m/NaMA7gLK21ELohNzgmvzn/8gRTlMCxFPU4Mi7wVLQ71SOCPkcXmURlQT9AGSMZB0Ytt1DySEJOiQe/cNN7hSuX0+tl2Qx7NT+823M1rLWuK4CXpykF/3914SDQhGUwr5MUi5J4KSzvyFdSqIgInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260186; c=relaxed/simple;
	bh=l9FdnEEzXGJIzRW8tkjLLu40rBvwdGZ+3HuMYVnHV0c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gi/2OuQYBCmV05ePn4cAIInDvNV+FWJzm43X/JfjHHSt/wl0wYZkWYfUPbpNNPCsfsR5RymN8YXKWfyYiphwj+YjObyNSRU5JJfCbr46GytXDlO4La/4lkn7TUr22PC+jISErc0cE4yJ/wXfsg1IQIq2V+rjB4fOO8yUIvs/Zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY0PfPTE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5176f217b7bso7188508e87.0;
        Tue, 16 Apr 2024 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713260183; x=1713864983; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOrASS+GeLuk5Z7lZoVL6cbT4rY+jK9WGpd682BgxR8=;
        b=lY0PfPTEYWx3kcy2BvEf2g5YMEzaGgaTXXscB3duP5LLocYwbs/wRAqP1+deCYH9pR
         +zL2SxHo3E6ldkUb14EQ62dYeTMeR/P5l69Gjn2zuyJqCIMMjNf8LPfVoFnNBVYpZO0d
         MnJ523yzptpiM2/ZTkl2bScF+xf7FNF9ypC1GUaXqzGjV7kQJeglZAHB01M255jeXuAY
         yYZRlGRKIuxGLL9QujbL9J0t2zVTYPcaUr2lSoonopqw7VUMfemUuP/gvhLOWbQdHEEZ
         rLvws4WBTn5Z5p3tmgcUCc4KJsCF0mNS+COS885bkk3ZPYn0j0y3NoxSdyN1mmobqNAv
         0ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260183; x=1713864983;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOrASS+GeLuk5Z7lZoVL6cbT4rY+jK9WGpd682BgxR8=;
        b=GUK604r5I4/tA4CSSc4vKPk+L1QZ19ghDuz9zjMdR24Bp03H/pg6nQKv8ger6/phhE
         7TDoD+BSzoOkX8NQ2GyG9T5mchLKb5yC9w1jGVsPFFifOx+UAYABXKbRmVcvzYfPUnMw
         GMvA/5Zjr2PDkV1FDH2Cm/GZi8zCoV9BnJ5498wD96e060q02hKxucJVGr50rL8piZ6g
         1oQttefWlUIjrz85GGt6jZFrp+BFYquy0z79pbPdJVlb3wCruNRQicpQqkCVGRp7aRmI
         suJuV+fuRxczzlrb46ifpovXnhmZUTgF6G1fsQcMJVmDmOC61XGTnlSMiJCgLUbf2RET
         RCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNJR3QS16A+E0K8Og7D5PFU1MuE5YpVw7LVXgTX4cDPvfPo3MuM/X+Cp2OwhLHyQT1IORXfvslO7weWU8lzL6zxG6dvApMGiQMiLN1W+KsN+i2ShMrzxBdecXYgMlmpGAr+VHlSOZ+Nb2zV3sg0IjX1t2UJC16fUYDWeTa6MaFwBDOjc+gn/07mk2q3CE5e/KPdKp1+7E4j93WULIfvrsYKLdGhxvhZK7awVKwZvyL0ToidOKjHdRAgVE3AYzmk0U=
X-Gm-Message-State: AOJu0YzJ/65ENuD+3nZxwQf/hFuV14ifrxVPvwnxG9NjZ/rqCi/0c6Dz
	WR9sXYMJp85WcmX26ygXPZe2Hlu+91+oW6n3yUboaRO/QdxTQd3O
X-Google-Smtp-Source: AGHT+IHJL+kGebuWf568L4j1/19JnbEd5orWvCbxsHgvPeVxrnDNkney9hr1xgtB5xtFbL8mR9qM0Q==
X-Received: by 2002:ac2:5f87:0:b0:516:cdfa:1802 with SMTP id r7-20020ac25f87000000b00516cdfa1802mr9934425lfe.63.1713260182555;
        Tue, 16 Apr 2024 02:36:22 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.107])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a524e3f2f9esm4249223ejd.98.2024.04.16.02.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2024 02:36:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [RFC PATCH 3/7] module: prepare to handle ROX allocations for
 text
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20240411160526.2093408-4-rppt@kernel.org>
Date: Tue, 16 Apr 2024 12:36:08 +0300
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Helge Deller <deller@gmx.de>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>,
 Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 the arch/x86 maintainers <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C4B9C1A-97DE-4798-8256-158369AF42A4@gmail.com>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-4-rppt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 11 Apr 2024, at 19:05, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> @@ -2440,7 +2479,24 @@ static int post_relocation(struct module *mod, =
const struct load_info *info)
> 	add_kallsyms(mod, info);
>=20
> 	/* Arch-specific module finalizing. */
> -	return module_finalize(info->hdr, info->sechdrs, mod);
> +	ret =3D module_finalize(info->hdr, info->sechdrs, mod);
> +	if (ret)
> +		return ret;
> +
> +	for_each_mod_mem_type(type) {
> +		struct module_memory *mem =3D &mod->mem[type];
> +
> +		if (mem->is_rox) {
> +			if (!execmem_update_copy(mem->base, =
mem->rw_copy,
> +						 mem->size))
> +				return -ENOMEM;
> +
> +			vfree(mem->rw_copy);
> +			mem->rw_copy =3D NULL;
> +		}
> +	}
> +
> +	return 0;
> }

I might be missing something, but it seems a bit racy.

IIUC, module_finalize() calls alternatives_smp_module_add(). At this
point, since you don=E2=80=99t hold the text_mutex, some might do =
text_poke(),
e.g., by enabling/disabling static-key, and the update would be
overwritten. No?=

