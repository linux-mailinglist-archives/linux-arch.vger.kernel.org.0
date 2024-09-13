Return-Path: <linux-arch+bounces-7297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7BC97889B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C414BB212BC
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FB126C01;
	Fri, 13 Sep 2024 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wroRNBrX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA514F102
	for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254702; cv=none; b=NJGd3vAme84THTC3yZpmagCl6/koe1Y5NWA5CsRmPwFMmEFFTi8GvBbNzSwXIdc8tVtNst/ULMrFO9uZYVEOZYs5AJOBIn0z3d78ReL4YWbTNHiujpo+9Km5qFWijmnI7j+4iKXzcD/KRLJAPa9rUaODXWrY9KQLONEb3OghvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254702; c=relaxed/simple;
	bh=df/OdVQzmZ9IIzivyT0nVwAaqNoCrQVBqFQJsmOtcdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQnsCmTmj9+6nHErXOoXFlAy5p6CjMQVHC8+Ub0SzbSCPbn+7CduxguGHuaW2qbvfiSN6wCUMCqzLHApI1X+yJV8+BblK5TJpHgaeBTaCPJROFH5vRFXHw46i8bQsgu9VyamiuBGKoBEWSTLaM0kYTad5t0xPqn0c6dRYado7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wroRNBrX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so4461648276.0
        for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726254700; x=1726859500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=df/OdVQzmZ9IIzivyT0nVwAaqNoCrQVBqFQJsmOtcdo=;
        b=wroRNBrXifviZNzryntxniZPn+arxL0Nh4JCbHM6SqVsnPfMvchzAZ17PLO6xruIfR
         U9tl6oIAONK7yKRTz4Yufr4XW74eNNVuoMKP7wYgyOgvSEDMoShIlNGM0yjF/w4HHGCw
         BK1PYUd2/5DL4gzJ8NW1Dn3TtLMq7rXyNSKD3o3AE1U85mk661wLL6tYANSrRbvgWpH6
         uTt0ZBJBFBL0oWqayKB4Fi3h2V9atHVfw15s/zesi8mtX+h0u3LtacD4Ow2svhk+fAma
         fsDnYrRAdEwLB2U5IxpW5GRrN1Z4MhgBbpISNQ3V66RVMM+2QtKkRpOBG8A/ZUTtkOEA
         JmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254700; x=1726859500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=df/OdVQzmZ9IIzivyT0nVwAaqNoCrQVBqFQJsmOtcdo=;
        b=sK/Sj9dlqfFoOcuZNrOXZ3Xo2K+cI7Bs4uuSAN+T7w08yNGUIiwGb09f9ERHPe+XOQ
         VoWBOA5KM3NJK29r50nckZDDwyJMSaOlpa+pldXY2KTBk5M83K1NVdUTIZwoY5NA/0Fj
         q/h/mPbVQ46+MOn5OBpbzVXXhGZDU+AVuEZIUs8qjmoN8MKO7TXEQ+uMOoIpcLSpPDqk
         Nu4two3fgIe9hOyxDSBtoWgx29hOS6y7G9+AQ0kym4hN4M/+OK/RbIVKJz+tljSwwc6K
         Ll/flGAE5I2W6l9+Vq8f4ciEhIJYiLWIhy5sd9Fd87oecUgqEHmg/HTZOQosf+zaB05Y
         9TyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB40TrS7dMmBgyLpkYtIUKjKLkU8GSQpqK1Reg2kXZKBpg38z2/H+PEzuNM7oTbdHGp0e3LcPH6vO8@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvlL7rmNqFpqGIRKZFm4P4ub4cy4ZMqc++MoT98wS/etluIIf
	TfiV6ALwjuy2YLPcb+kUYrW/ZFFLbe3uTrR1Cz17xPzAj4vmHkxYrUxr1TRMEScb+1HY8upmHjk
	dIQ==
X-Google-Smtp-Source: AGHT+IHWKdvpTgRToeIjzP7LiLbwdIQd0DfavHeMBa0nhxmMEncC0lsKplD9gP28OszQ1s0UsOTgeX3hi0E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:86c9:0:b0:e11:5a3c:26c7 with SMTP id
 3f1490d57ef6-e1d9dc4275fmr12810276.9.1726254699289; Fri, 13 Sep 2024 12:11:39
 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:11:37 -0700
In-Reply-To: <20240609154945.55332-12-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240609154945.55332-1-nsaenz@amazon.com> <20240609154945.55332-12-nsaenz@amazon.com>
Message-ID: <ZuSOaTw1vgwquqTE@google.com>
Subject: Re: [PATCH 11/18] KVM: x86: Pass the instruction length on memory
 fault user-space exits
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	graf@amazon.de, dwmw2@infradead.org, paul@amazon.com, mlevitsk@redhat.com, 
	jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	amoorthy@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> In order to simplify Hyper-V VSM secure memory intercept generation in
> user-space (it avoids the need of implementing an x86 instruction
> decoder and the actual decoding). Pass the instruction length being run
> at the time of the guest exit as part of the memory fault exit
> information.

Why does userspace need the instruction length, but not the associated code stream?

