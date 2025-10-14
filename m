Return-Path: <linux-arch+bounces-14089-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2FBD6D29
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 02:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 052CD4F5140
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62534BA45;
	Tue, 14 Oct 2025 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD8oKD+N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D0A95E
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400172; cv=none; b=nL5yRoXD6/cxVie8byoIsTkGjONExBDD6JeaTBWoBfJc6akyoL+nYxxx4lW8vW7qFV0TBNHcuC/73XkSeUFECRWp+hj/3qbunqFrCbJsTKHGmnwiK4G2/0QCWETCwfgRmB2th1ncarX0S5R3eGUmj94GxpI7CwuDZEU8omTV914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400172; c=relaxed/simple;
	bh=LLOVlwAfJOO/6dIvSHatLzz1DYqRKk528EsxcLVUzvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JFJkCsfoFuZ8xF5MTdBtF7HIu08y+PbPap2DXH9DBQp0wk47teSdIwbKZmOcEuewRc2JfKz6v5jtKDdQ2AnHrh5eQkh83/WHf3p54YNLtcJOYGniPUV0GHzsiJg9Vmtqjbr7eUnGOI44hytC+QTX+Qtrbqr4oszkx+XcJMj7IsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD8oKD+N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc5bso10734362a91.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760400170; x=1761004970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbMLU0DBTTE4ZUI3tpJtNUcx/FkgYHD5aLH5yKQ0ecU=;
        b=JD8oKD+NJ3FkLOgbvK1sNL9dzwSNKL7TANNwuqWE6HqfiH28V5nOBMtLZCa97Cw380
         o1+RK+pYsYsE7CKot3wknqNtCHx0BdJatgmjRVwHGB/AwiaP0pnXHV7KSvzOpJlILniz
         17g0GQAO2+vz8Dx7pXrYxzXkZWIdyP1yyQBtDGODJj1fecW2arJm8ypZK0hh7FxqG+Bp
         bZhHmlsPSD0crstYbRRzwIATpTr4OplqAZPGrA2K7qSvWLh5F9ZzCJLQZFhNmqrt/uTX
         EeZQsRMS1zMDf+PauZFLipU5KUd8TUmFOIxkpy7lsZZ3aPnf0+LbZeo3Hcl3P4Gfug/e
         4eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400170; x=1761004970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbMLU0DBTTE4ZUI3tpJtNUcx/FkgYHD5aLH5yKQ0ecU=;
        b=W+xk8Wz1L8Tbqj2ZKY5eTnofA5KJOBzktOHvzSWx+dNKItkKjIlM2efjPaMDbfRfto
         3cDrNltL3XUpOpmW2mb5g4fjM77A02Hx599nuwXHsc+INl840UFGG5MJS51fBypjslPh
         ohYTF/DJIuUKv8efgLBcs1sMAaYzcT0jBmIBQmHQcYRvVkT8tuNRpMi8dwqTUxNgllrF
         UtcMljn7yKsp7YUGw/JfaNzGi63jt34XxqjkT9m0MCuwuznA0bywhEsfR643bEkpZlU8
         RcJeYZ+mHK7IEYgUJ5GqUvNAlBZlp/oYU/vFe4nLDaGzy+MKpKmHhOFQ6x+TBGKZgFSW
         cd7w==
X-Forwarded-Encrypted: i=1; AJvYcCW3Nmo0qvPcIuuICqj369q0uIHPMe3lMM9vGiNJ2zSA4oE9mu/h+ZsIOJSgAAcOt5mO81LrwWi47L3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XuknDczv7DM9yhGh/dFvo82FKPbQHXuIqHUPjWd3RjA+QF1w
	lsduckrbm7uPChIuQAaBq7jlsdG9e5Qjvj1+c4GSiMrgytRLSSi4aucinRN/YxH6JEIbSwpLJHv
	LiZydeg==
X-Google-Smtp-Source: AGHT+IFj7XEk3dTkPnLos5082VprjEOkbmDHEla6HA+8/jfX0ozELV9F0rEtoGCDSVNCkEzGlN6/hN7WXyk=
X-Received: from pjzm8.prod.google.com ([2002:a17:90b:688:b0:33b:51fe:1a75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c89:b0:321:9366:5865
 with SMTP id 98e67ed59e1d1-33b513b4afemr31472790a91.33.1760400170137; Mon, 13
 Oct 2025 17:02:50 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:02:48 -0700
In-Reply-To: <20251010153839.151763-17-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010153839.151763-1-vschneid@redhat.com> <20251010153839.151763-17-vschneid@redhat.com>
Message-ID: <aO2TKOY5JV9OoRUg@google.com>
Subject: Re: [PATCH v6 16/29] KVM: VMX: Mark __kvm_is_using_evmcs static key
 as __ro_after_init
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, 
	Yair Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 10, 2025, Valentin Schneider wrote:
> The static key is only ever enabled in
> 
>   __init hv_init_evmcs()
> 
> so mark it appropriately as __ro_after_init.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Holler if you want me to grab this for 6.19.  I assume the plan is to try and
take the whole series through tip?

