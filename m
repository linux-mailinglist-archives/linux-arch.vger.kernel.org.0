Return-Path: <linux-arch+bounces-14429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE891C244B8
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 10:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6392188BB33
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE27A33290E;
	Fri, 31 Oct 2025 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDS6ufCW"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332D2EB87C
	for <linux-arch@vger.kernel.org>; Fri, 31 Oct 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904544; cv=none; b=tddpejFJ0pnErI6D6ZVlMFLc/H5iQys4f3BA9xdMt5j+9odmU93YrbcTNFSHOpepDFdswGM3hzygo1cl0XTLn5vEBH1/6eheDyu/exgikbBVR3F888iXpcwEPUm4sUuTIGfmvFks6NFK9bOX08bqQEySu+ajQj0gLspTU5CAHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904544; c=relaxed/simple;
	bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rYeIIwcD2ENNFmz3YpZxegCI3yIUPEJPdtzno9SZdfjWec4e2iBvGwTD221D406RZXeJKMs8Ky4VX5BeCUOlG+VZ8ihuwpCafQG878w0VLo1gRe0vYiGOgTMMhljCPd64QUthmdSZ4dvzH+ZkCh2DY8XG4Ho7gtARePcu6LXlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDS6ufCW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761904542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
	b=QDS6ufCWZz1lF5hV2Y3i6QUMRhHJ3h3sQmCe58iBzunyP0lpcKoNbI7hfnRw6ZH5ermo8b
	aFE1Hi2m2p7UXvYF+Rt6kU1jSdHce/RhKGA1jcMfsAHxa6loKvfnWpDdYH35BoVa0LacRQ
	McuFipCNuI/Ry+enNMx2oUNw+oClcC4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-zqcNjcLqOi62aqIrswg7Nw-1; Fri, 31 Oct 2025 05:55:40 -0400
X-MC-Unique: zqcNjcLqOi62aqIrswg7Nw-1
X-Mimecast-MFC-AGG-ID: zqcNjcLqOi62aqIrswg7Nw_1761904539
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427015f63faso1209247f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 31 Oct 2025 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904539; x=1762509339;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
        b=RmFwlX6WFmm6VQ+QQFnLd6JQN61Gy5VRpOU0BjPm8NMSBHOJgDlRPBPEb4bZtLky1h
         7fl7rBTgtiVe0uH+KoMUUyW9W7F61rxGdXHo+jOU5CYpeq/uXLbhvGqZ/p4RvHMuNQtL
         6LY5p6NDn5l7IC9xhAbGQS3v6rXTS7yMjpQOTC63KUaoA5OrUeLkgh1n6J+XoGWeZsWb
         eYE3Ix2VYa3wRDBG7XNUA+Zv4Z/JykurMkymPfQm1aMjNE8n4qQhekTfd8dpXwf1g0Qz
         4q+q3IqOkLN4qBwaHFswMol5Z+cqGf3+dO1kGkWGFqCIUuCYQj3Dka+ohdFAuaR/dNQQ
         AUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaVQYZDyH60VASeZ42bNR4nPDCvKediye8O5vgt3dS+79ryNeAEaUOLPl+7T3s5DCgvon+pl4Cg2/n@vger.kernel.org
X-Gm-Message-State: AOJu0YzYId7p454qORzZBICAapFxnAwkKGMZcWH/L0FSK46ZTjV4fXvw
	L4fIGv5OMTcURE9MybKNUI8tHcOEt15oaR77tl0E/Z3zWrwqoYW6IDAg8GGJdqmCWctpBg+ZAA5
	mHKYS9iV7usFOEj/2s52VqrgrusoFS35m6JwDEbqCCwvd/KnJVz/bDDTX6mm4gfM=
X-Gm-Gg: ASbGnctrXMvvvh9EjYahb1vok3mmYB1G1KdZvpeQjY7b9V+rpZMcjStSTI8icfRVQ0Z
	oKZe5IYr1L50MYiEQjhZOG7aW4OwcdL4qy2Xvq581KssXjXrvwxJ4q8rbn3X7VwPczJPGad+IXk
	xB54YBzVOMIVcqS1h+RarNkhwgP5eUB07az5K3whRPOTI2jIOvHVUEM4AF0PRWbc7n3wk9ZGD07
	0zhAOQIptlUSNiNyAOR7pyVeBJiDi1vQXzXxzMDS4yZK5tYK6XxVbLW+KfKocTYYR09iVN+A+ge
	fEbHJHYlZ5A1tlou4O96IRiG85IPrUuLmH1jO8UK27L26+i3t1LRSYZs4altLf/FI45od9bkNhm
	udO4OTN6Fa0zHrps5GmkKKsiXZU5tgCaxcsm4ehG41exruMCn4iAisJ3Y5bO+
X-Received: by 2002:a05:6000:310f:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429bd68869amr2437818f8f.12.1761904539505;
        Fri, 31 Oct 2025 02:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbUxApmJAOYlrcJigfNqaTRZ7Pz52J94NiUAhMgZ/Qwj+7BmCVMNCnPqwOLJ11D9kpjdgFWQ==
X-Received: by 2002:a05:6000:310f:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429bd68869amr2437793f8f.12.1761904539055;
        Fri, 31 Oct 2025 02:55:39 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1406a45sm2624895f8f.47.2025.10.31.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:55:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQIpXyX-z8ltB1i5@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQHtBudA4aw4a3gT@localhost.localdomain>
 <xhsmhwm4dpzh4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQIpXyX-z8ltB1i5@localhost.localdomain>
Date: Fri, 31 Oct 2025 10:55:36 +0100
Message-ID: <xhsmhtszfpf8n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 15:49, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 03:13:59PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> Given we have ALTERNATIVE's in there I assume something like a
>> boot-time-driven static key could do, but I haven't found out yet if and
>> how that can be shoved in an ASM file.
>
> Right, I thought I had seen static keys in ASM already but I can't find it
> anymore. arch/x86/include/asm/jump_label.h is full of reusable magic
> though.
>

I got something ugly that /seems/ to work, now to spend twice the time to
clean it up :-)

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs


