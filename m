Return-Path: <linux-arch+bounces-3616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B18A2AB1
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B06288632
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD53481B3;
	Fri, 12 Apr 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOfxs4gw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2138DD8;
	Fri, 12 Apr 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913377; cv=none; b=NGjY0MkPICJqk/pof9+n6eROPtux8P3oo4vkhsrc9cKqDZjV5cpyT7u2inrB5kjMgXf0wHTSxfwdiP3Bs+AVUEgIyNHlE+Tuh2l7KMywTkCzlbonoV2iUChrYhMbwKiGICrBDWEh+lwai70zycKHLIFMMtlUaSjjp37WyI7sNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913377; c=relaxed/simple;
	bh=T/TL4P6RqoXnShkICgxGFcoEXV/L8guRkl+BR8oz3qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra6zP4ElDYTP0tsWtoX7uKraN2Fj4uGF707LCAB37cozdE29w55xB3xd0Zkby9UPN7Oxk8aI4me7VVNWYtCLWHY81VT6R6wmFuzna4JQkiyjs7UrcwtBGxUU1/s8fTQJDl39XoH8UbiIuUmOBH5IQfE0Rp1J+ShVeD6GTna4HPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOfxs4gw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso974821a12.0;
        Fri, 12 Apr 2024 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913374; x=1713518174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1P5rS5dDZ6bz9RnNGWXjXGeZ5LSFZB2izV8TdsSyfhY=;
        b=OOfxs4gwGdSJYF5Rg1YrEPMa7aeAv3TXdkArvWg7NxpuxZ+eQflhdOQQREts0AWpFH
         OiCjfBQWQM0eYpv+b8QlzIkfhqgKkAdXKkJ8xIU8keCiO9qD/6L8dCADBbUJEVR7SxOq
         DXe+RoOC2Be5trhfR+hNGmrVl3wkxSAYTZPs2i9bGawVCW7V86nVB/xqHRp8Fa9TCSWU
         CandjXr5Bdh9jksVy37KzaU4YV58iY+HxPJIOPrgmqGt02QA+sL8Re56nvhddQ6DY2eF
         UcnPl1y3nY7H8667oqVxZ4Ffu5M9GMM6NyAnNb1sjVlipM0fP8lSJYGo3BRU4KwtP3eZ
         jpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913374; x=1713518174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P5rS5dDZ6bz9RnNGWXjXGeZ5LSFZB2izV8TdsSyfhY=;
        b=Z7lqARcsm6CccpGbcjPISLnBHKJzfNk8pN08gMcCL2OD3v0oZ0/SMs2OiwRTOpBS66
         UuLBr6pEQMRqfAx7osL/08VFpRekxub+LdF+7tLpgPE1dfMaxzkHqwcIMJG1mXJQMZ7t
         9PZrwjuT2iCh6fEGmlxk3oK9HBfOz8FE/06p5wNK5Rbm9G+6HnSCTom7oNRXXoO0B4kW
         TVdoS71chMLO1cCRDoJf2cSakvoeMGukwQlZhISe4S/n8EPmoIU26FIBaAwmqCjrzANI
         UdmP9LJqNt651L/m/urQUZkIlfQN7nSD2+vN+G+K1eZPM5wp26fTLkGHNmB+OuCZYlh3
         yN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPEX8P9Ow3xwnnn9l7E+J+ej1dDoB77dawHjEnNWSfOQaUpOd+hs4GzMVrq/1LnBkieU4uQ31wxq32CJDrxvg/NqZoY2COxkKJRSHIBcGxqutnoDFKDvsf+dw1f9PH8EyZbtjVbi52w7E8XZUUdZtC0xeQPm8U8qufFe7KeJU7eO+wSKqwXwRm4wM3VAjXQssJ6AkJcCoJO6qiq/5+QTDyWlS5CK0s6wL1s6NSakFqVgpyqhXT6Sm4rKSOLaKufjhtwXYCHqDlQYissNSY7xIv94C/p4Gm5aTYKBAZdNXF62AOWRe4iIDpA1IOYPqEpABUKjqzrwlTr1vJaJh34/BRBGBguHXOjst4+BeRiitNh9CakGpdgRUTdQGtW1u5lXxMKI6YpVUv/kIFuhg=
X-Gm-Message-State: AOJu0YwKcgA7Q+Mgdg5hZnfBVwvIn/EJqMurxXosdswDTSCgg6jk3TYh
	LcchT5B9Af7nZ+vSdVKRii+R89lIJIkMEZvMIvNwt/g3+6m/jGIU
X-Google-Smtp-Source: AGHT+IF2JLt070H6U+NVwXUCGShMgUTVG3TFLf6L4pd2nPVSBBMwXn0qR7EXkAPf+SwG43RHlRZl8g==
X-Received: by 2002:a50:f68d:0:b0:56e:4039:add5 with SMTP id d13-20020a50f68d000000b0056e4039add5mr1892328edn.22.1712913374186;
        Fri, 12 Apr 2024 02:16:14 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id el9-20020a056402360900b0056fe755f1e6sm1454709edb.91.2024.04.12.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:16:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Apr 2024 11:16:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
Message-ID: <Zhj72l6uN9OFilxA@gmail.com>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160051.2093261-6-rppt@kernel.org>


* Mike Rapoport <rppt@kernel.org> wrote:

> +/**
> + * enum execmem_type - types of executable memory ranges
> + *
> + * There are several subsystems that allocate executable memory.
> + * Architectures define different restrictions on placement,
> + * permissions, alignment and other parameters for memory that can be used
> + * by these subsystems.
> + * Types in this enum identify subsystems that allocate executable memory
> + * and let architectures define parameters for ranges suitable for
> + * allocations by each subsystem.
> + *
> + * @EXECMEM_DEFAULT: default parameters that would be used for types that
> + * are not explcitly defined.
> + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> + * @EXECMEM_KPROBES: parameters for kprobes
> + * @EXECMEM_FTRACE: parameters for ftrace
> + * @EXECMEM_BPF: parameters for BPF
> + * @EXECMEM_TYPE_MAX:
> + */
> +enum execmem_type {
> +	EXECMEM_DEFAULT,
> +	EXECMEM_MODULE_TEXT = EXECMEM_DEFAULT,
> +	EXECMEM_KPROBES,
> +	EXECMEM_FTRACE,
> +	EXECMEM_BPF,
> +	EXECMEM_TYPE_MAX,
> +};

s/explcitly
 /explicitly

Thanks,

	Ingo

