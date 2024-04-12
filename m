Return-Path: <linux-arch+bounces-3615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6EA8A2A55
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074AF2879AD
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8313E479;
	Fri, 12 Apr 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxaisTxM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B321B5AA;
	Fri, 12 Apr 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912888; cv=none; b=AIaxB0lG8UJ+0aWlCF2Oo7pn8wEnrvybhvDue5zON3GYEoz/X+ZzPlJ0SrspiKbL4dRZ9QL+b0+N4MZt7g+O0TLVquYXBVv+8eC0qz18xoOwMWyreJhVGnebdDJEhMBAFKsBx/4thLgCV9R1P1zOjcKmlyKqPbrcHMZdw9CRFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912888; c=relaxed/simple;
	bh=MVi0TpJWrP3KG1T/04QJfQzY+bs7CEwX4l3nbgbsSjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEMm+9imXYMJunlsVDxU+nBVt3yZaIAl+Y8xooSaEzxrroP1LLbZ/hXwYpJ55tdNHnIBYmCA77ZkRox1OCRKGfMDHrsn4Z+OGPeK/4NRszDMbsebEC953Lp7GrvQOHdGMkqGSXmicJb1WypoZqN2fOS5zDHlxd3TW1KRiDmdm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxaisTxM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46a7208eedso89413466b.0;
        Fri, 12 Apr 2024 02:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712912885; x=1713517685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPUGnUPFGvIHpfCf2GVNK2vLyHGdD2DrkaoFCTmwcrI=;
        b=DxaisTxMOqBaoHIfgWX/DJdCkgysHeh9kBGMR6IRLAU5Elel/+u6XHQR3h2JafdaRm
         i1YzM+Z/rhOWwJ05myMM+co1IhPpsJeJmx1bL5yFjZ8ZMO8EQrAraRA14yQqYL01AWw7
         yKryVIZL+MBrU2SxsaCAWBJjQ/VarcvGUOBwU1f9Q8WmacnAU+KN6tFnpA25lglCupaN
         6wrPsYwbYms7ZBvcH15+0v8KIG4S0aDg3sfDkRUySEiVhmGR8d+JLDWBGYeIpprWJSPQ
         qjIoS/0msQq+AYD0N5DSuvY7VHHtm4pnW6CXe4uiQg/5idYgYUvvz5nzl5NxuHiXsYVz
         ed4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712912885; x=1713517685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPUGnUPFGvIHpfCf2GVNK2vLyHGdD2DrkaoFCTmwcrI=;
        b=NUzedmvLnyleC7OEFfd69dCO2x7AB5ybG34MLQjMhTeL+vmaVpNBiZ44S4toCTawlC
         v/+EQ6WQd2a7sRvpVlcpYebEFmrGEw1G6uU/IfXL8rTY+iz6Ggn+FQxk1wJ6qdMPOTv7
         is6ekQdMkPbulKEH4UVEjzJs23kmUps5+OC0DQx2xmXVx4BZbD+XdLuN47ZD1xbUcK8Y
         ZRYTA38SalWhFYJaaG/rEVIoMxtM63TH9mYnXkWhWlZwazU9OLb21CbyqYolyesv9ymS
         pc4l7n/xRXLx6MGKI86bxwe/gRC9nepwMxh4zbvD6EbOx3sCc0Nwat0Z1Wn8zp9Z4dNW
         X/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGK07TSTeDN/SrtTSAbwsb2s16soMnO5PfwAahBwe+GW3oYqOeM13qRTS8OkxlM62MXLRnue0udqZE7lLdUbTLL/48mvjCL4TxBu6aCUPpWEx/YXSHG0cTEP5p9FxYoSbvoEg4dH2eSSFdzMDms+IHcacz6+obbTXFHa/mHIDfg8m0DoeNJo17y+3UcJdho8NBAXO9T5xB2MN8LTTfTkkHB/TnGOIRtJKW2F3UUXGVpt3+47sf5jQqGsDraQMpspk=
X-Gm-Message-State: AOJu0YxB9EGVB8xRyQXVP5uWxh8iksXegdIKlbFEACjwFWpmF0QphNb8
	UbFPRHIBazVI0VkNq/hZBhb6ucdfmjA7+d6rJ++6TcRcZioqyrrz
X-Google-Smtp-Source: AGHT+IE1JXTG/LcQoI+lnHKGTMryNiPMKyUlJP80kVd4eHhaWi8p2N8JmnjvJqW2HLQ210FFl8qPZA==
X-Received: by 2002:a17:906:345a:b0:a51:80d9:56de with SMTP id d26-20020a170906345a00b00a5180d956demr1236428ejb.5.1712912884326;
        Fri, 12 Apr 2024 02:08:04 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id zg22-20020a170907249600b00a51b18a77b2sm1572994ejb.180.2024.04.12.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:08:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Apr 2024 11:08:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>, Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [RFC PATCH 5/7] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <Zhj58NVS/iQnPeIq@gmail.com>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160526.2093408-6-rppt@kernel.org>


* Mike Rapoport <rppt@kernel.org> wrote:

>  	for (s = start; s < end; s++) {
>  		void *addr = (void *)s + *s;
> +		void *wr_addr = addr + module_writable_offset(mod, addr);

So instead of repeating this pattern in a dozen of places, why not use a 
simpler method:

		void *wr_addr = module_writable_address(mod, addr);

or so, since we have to pass 'addr' to the module code anyway.

The text patching code is pretty complex already.

Thanks,

	Ingo

