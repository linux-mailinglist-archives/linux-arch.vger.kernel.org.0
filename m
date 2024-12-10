Return-Path: <linux-arch+bounces-9349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB849EA6DB
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 04:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431F8288D66
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574B1D88B1;
	Tue, 10 Dec 2024 03:59:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8671D31B5;
	Tue, 10 Dec 2024 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803156; cv=none; b=E67Iwc+1Sh+G7pw33F4KFHxZRZ7pyPE3Cu/RHrk9TxUYtgHnZPSQhWgQk7jYRzEpDLJVz1HaBIiX7V6XmnneOn83YfTOBapQYdcvTBqJlVm3CHDxd3pc/rLYFDbtfmqK3vwql3TregZUkLO8sm3kQCwvvMJN1d91bmrVSrJ49uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803156; c=relaxed/simple;
	bh=EfORchtwnv7KmnN/gELMeKzTjGN3v+5Zf9FNg5xJ5MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFoe4MXbeOsAwwDZgYx9Z0j3AFtSwXt6BMCTcRwpkNOXhIS5aZFIpZPOxjxNxfU/ueNPLM5tbGQQSSUJ1F7BwSCE5RAjdKnykO2ZZzLkImCMzfhmDoq0vguZD2qCO2hH5B0lW47cq/Fiw0rh9mP6Bf+k5KRrYPqHIbr1tRKZtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725f4025e25so1175868b3a.1;
        Mon, 09 Dec 2024 19:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803154; x=1734407954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZdH4tcmxivh4QDFce0d2NRScLtiuHUjaYwYxPLsFgg=;
        b=YatOcGn6cijC95Uio+v8hNwv1VeEeQ3y6sYpoZ6q1FKXynsJ9st510RmW6Vdf8nAIC
         RZS4IW4VtLbSPL/u1s3PYY2ae6091cCsC1s7T2XO6guH5QaJR9YKLOJOmAeA6lXEtyJx
         iy45zR+nymkBrme2l4hBkrUnhktmo8indGrighMQ8KZoaRYOwTcmu4J3G8Bm+av9c7Sd
         pv+IhGXzhjlhoqupKZrDi1X1O3zH/ZQo7WI3rj2yu505TJiLWFdB1dXR/bk+OT4i50Tg
         KOZvmURs+uiHUUV34o7+zk2mgp91aSBQyuWV2sio0PgEoIlC/Q8TpzWVX9eR7YMjWtmj
         JfeA==
X-Forwarded-Encrypted: i=1; AJvYcCUMnjsO/BTQWODCY6VW39lyA2pTLJ6PYSO4ItGocG8u0M7Cxbe7JNlZqFUeQiU1aJwyvx1e5gwLZ0hx@vger.kernel.org, AJvYcCVZRhuHbCytWdVc3wZKZ8hEAnMZib1YZ/tXoT/X02AGuqd33d4ibVBsJiX0WmaUMBVcPkd429qG5dy/3NZHnxE=@vger.kernel.org, AJvYcCWxEKTUpNTY5eL4iDvQ4ST5sWkq9mnPLTEMaLI659ac1s0pXSBgRm3BIhJcv1uDdOWj4ss6YE7e@vger.kernel.org, AJvYcCXjYr8f24s9SEtJreW5NzNd5qpHYO0RqLVEbefR7KYTo+ycssbA6HBy1eQqqdZy006TofudCkpqradRUmDk@vger.kernel.org
X-Gm-Message-State: AOJu0YxggFdKkRVuhgFoFID+LW4GrKSRlg2/iHHzbzmlVpKX50AJ0hDe
	Cz0rrEAeMhftE08odxatWeEHJ9D6GrihNLVO+JbdBUhkWOLljsR6
X-Gm-Gg: ASbGncuqQvd+SfqqTWIBfYDH8DNsZmeqVTfoT1JwwddY0EwgidaZwD3iCvjOf+SHOj5
	LVkfY8JwTuOokQ88pQdrjnklLNK7pxVkbUm5tHpfuDIixEuu7LvythAYNm9qJEzyyj2U15NYoHb
	454mZPWHOML87o6QAtYf+QKVa/52ipGgHkEws7nu2DehxoFTAowmdHZAZzDGU33+t6pcowKrZXC
	NbgWDVVSlO8e51aoamXcgkfusC97nqWqLMCScIqqN8yBFrAQKaJN4IXTkNtPqzNdA4lL8zXbhwM
	P/i8BvAtf/fwqTjRcb92/w==
X-Google-Smtp-Source: AGHT+IFLYl8oqU728VFGIiHD6jjP0ttkMIa5bvlvQdGUuldgwTreeyu+gObx0DLr0uZOxz9WXJqBCQ==
X-Received: by 2002:a05:6a00:1c85:b0:727:3b77:417c with SMTP id d2e1a72fcca58-7273b774407mr5601322b3a.20.1733803154288;
        Mon, 09 Dec 2024 19:59:14 -0800 (PST)
Received: from V92F7Y9K0C (c-73-162-198-50.hsd1.ca.comcast.net. [73.162.198.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c91baf30sm5510482b3a.80.2024.12.09.19.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 19:59:13 -0800 (PST)
Date: Mon, 9 Dec 2024 19:59:10 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] Enable strict percpu address space checks
Message-ID: <Z1e8jtHt93l0ONu1@V92F7Y9K0C>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208204708.3742696-1-ubizjak@gmail.com>

Hi Uros,

On Sun, Dec 08, 2024 at 09:45:15PM +0100, Uros Bizjak wrote:
> Enable strict percpu address space checks via x86 named address space
> qualifiers. Percpu variables are declared in __seg_gs/__seg_fs named
> AS and kept named AS qualified until they are dereferenced via percpu
> accessor. This approach enables various compiler checks for
> cross-namespace variable assignments.
> 
> Please note that current version of sparse doesn't know anything about
> __typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
> when sparse checking is active to prevent sparse errors with unknowing
> keyword. The proposed patch by Dan Carpenter to implement
> __typeof_unqual__() handling in sparse is located at:
> 
> https://lore.kernel.org/lkml/5b8d0dee-8fb6-45af-ba6c-7f74aff9a4b8@stanley.mountain/
> 
> v2: - Add comment to remove test for __CHECKER__ once sparse learns
>       about __typeof_unqual__.
>     - Add Acked-by: tags.
> v3: - Rename __per_cpu_qual to __percpu_qual.
>     - Add more Acked-by: tags.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> Uros Bizjak (6):
>   x86/kgdb: Use IS_ERR_PCPU() macro
>   compiler.h: Introduce TYPEOF_UNQUAL() macro
>   percpu: Use TYPEOF_UNQUAL() in variable declarations
>   percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
>   percpu: Repurpose __percpu tag as a named address space qualifier
>   percpu/x86: Enable strict percpu checks via named AS qualifiers
> 
>  arch/x86/include/asm/percpu.h  | 38 ++++++++++++++++++++++++---------
>  arch/x86/kernel/kgdb.c         |  2 +-
>  fs/bcachefs/util.h             |  2 +-
>  include/asm-generic/percpu.h   | 39 ++++++++++++++++++++++------------
>  include/linux/compiler.h       | 13 ++++++++++++
>  include/linux/compiler_types.h |  2 +-
>  include/linux/part_stat.h      |  2 +-
>  include/linux/percpu-defs.h    |  6 +++---
>  include/net/snmp.h             |  5 ++---
>  init/Kconfig                   |  3 +++
>  kernel/locking/percpu-rwsem.c  |  2 +-
>  net/mpls/internal.h            |  4 ++--
>  12 files changed, 82 insertions(+), 36 deletions(-)
> 
> -- 
> 2.42.0
> 

This all looks good to me.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

