Return-Path: <linux-arch+bounces-7628-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA398E298
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFE5281BAA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552981CF2BA;
	Wed,  2 Oct 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FIaawmqt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A991D1F44
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894024; cv=none; b=cXx3Bs2oc3dV6T5YGR/XMN9Nkjh2HYXBxzCbQxu/xzyBujNpx6bDFYDrTqhSqJ4sldIR80kgu8wXhDx4ZcRN/adF/noVna2PMRJ+AZRDM3kro06PACuSi4kPKs6wIzQ0w+66aLmhPOhwI+v8vxr4muXDwG99hJezN+tnYgvTrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894024; c=relaxed/simple;
	bh=AjMuW3cUPqvX5IXf0tVKVsi6FlVddUpdkqEr9qZyHG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXxS8ESF6GgGwRtlri/lYMTVZu84GtfcH5Y7ac36puyXhVRXrd4OSXrAbzKDCzeg+3twhMgOPnSEHMXTFtg3Lq4UakIhdSD35Cj5tPMHiynyt1v0HSz8A7b5idD28vopQCrC+l/metb2n0+DjOfVPf5KdxZVet3UgqSp+Z4BM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FIaawmqt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so8015366b.0
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727894020; x=1728498820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nuETLuv/R/DJMMuFcZ4I+Mj9qc52mZmXcaPl20FH7fo=;
        b=FIaawmqt0DtOhYxeSVYCsqdpYtmRgYxc+GRiVCfU7yHaLwUA/Ah0/S8LujHMNErpwn
         Uw5ERdgij4wl4FbsVJa56lvgcKWuS6H0mM67/x1e+Z7HnDLXjxyXdlM3sdZtO3OpAvjX
         0MqFlL2+4j/e7U3o8OLOENpsNEmb8vCLbnzdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894020; x=1728498820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuETLuv/R/DJMMuFcZ4I+Mj9qc52mZmXcaPl20FH7fo=;
        b=estTDzVAszwNHQLF0jBO3TIq/jcqwL1imTMZIZIo3l1ZpUL00OgpCRJsO4nq8qW0P0
         dmQxvmPlC+4ezlKed1O7gfv+vGY5P06hWwQ/ZiKglzjm4bTp2IjmVnfI3gBcauQ7KCR5
         mwarOJ0lQLzcRyUMtBzU//rebGehdfy+WoM7QDYJ1pLzbFTN0e8U2kMLvVQGtAvOw6YB
         UGLz7YusUgEQScA36f6Gn7VK9RiJAYpC8diumYW3Lu92SZ4rj21A8ankUatfhA7nrl+h
         AfxMnB7mCE+bGtN61Xu/ehXRaEI4Oyxb92HqUIxuFHHB9CqmbTqan89E36pkeQn+2fNy
         ZjMQ==
X-Gm-Message-State: AOJu0YwO6wA+HC4F1K7Jh/k66of0Oio7MPfWChMCILSzEXzNvqKb1u4F
	txg1mq6THKPrUq19DpFmo5ejcDLw8fSWf8xVztbIqhUX6kYxpaJxqrrYtEmIy7iGhAYgdKpQqP/
	/sQehCA==
X-Google-Smtp-Source: AGHT+IEzwnb5bXTDPrH4kiZZs/jjhw0BiatTzc82dRh1kJyjhk/oN/ahiXABdaQpuNqf1yzCPhb3+w==
X-Received: by 2002:a17:907:7ba1:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a98f82450b8mr360667566b.21.1727894020560;
        Wed, 02 Oct 2024 11:33:40 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a30dsm901138866b.160.2024.10.02.11.33.39
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:33:39 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa086b077so8012566b.0
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 11:33:39 -0700 (PDT)
X-Received: by 2002:a17:907:6e8d:b0:a86:97c0:9bb3 with SMTP id
 a640c23a62f3a-a98f837d570mr382833266b.51.1727894019353; Wed, 02 Oct 2024
 11:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001195107.GA4017910@ZenIV>
In-Reply-To: <20241001195107.GA4017910@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 11:33:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7f32w8p1OrN4fahaF+44zWfTAD+3ucd=XETM_Pt-=6A@mail.gmail.com>
Message-ID: <CAHk-=wj7f32w8p1OrN4fahaF+44zWfTAD+3ucd=XETM_Pt-=6A@mail.gmail.com>
Subject: Re: [RFC][PATCHES] asm/unaligned.h removal
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, 
	Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 12:51, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Please, review.  I don't really care which tree(s) does that stuff
> go through; I can put the first two in my #for-next, as long as nobody
> has objections to the patches themselves.

Please just add the whole series to your tree. I see you already got
the ack for the parisc side, the arc side looks fine too.

And even if there is some further fixup required, I'd rather just have
this done and do any possible fixups later than have some kind of
"wait for everybody to ack it".

               Linus

