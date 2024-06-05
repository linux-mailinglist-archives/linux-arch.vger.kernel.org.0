Return-Path: <linux-arch+bounces-4721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5EF8FD6BE
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F8CB26043
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0FC1527BC;
	Wed,  5 Jun 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/owO1Y4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185701527A4;
	Wed,  5 Jun 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616899; cv=none; b=Um27+sII0lv1pLnsojSC/L4dhGq47663xnhTbc56x7h4eYvuATcOy7e2EDsFRdlTH2gIiJiAtj/ifPeSugXk3nafbt1OvTIrvgW1MYhRIUdgao/N0t2wOC1UhOib0FjtE/JIrx9VLrIQdM7vi+DxKEszOXruniLdWLnyo06DmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616899; c=relaxed/simple;
	bh=XcdDn8GRuH1jivZnqCMCkm6WnnGCrtFIb7Gb+6X9MwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFqu9dnLKL0X/TF+dk+zxPJA8F2LdRt2lL+IYicm1RNojqU9Rcw1VFbIelJRsJ3gX2ZXRLsvE2elW6VVeqVN0mhlQAwH9GR/4wxCHKQYG/0F+l4stT3FkFshbBx0O+XW9lazDQi2B1SAzWGqErahj2Gf484aGv18tOkG+wDqB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/owO1Y4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42133f8432aso1436935e9.3;
        Wed, 05 Jun 2024 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717616896; x=1718221696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WU3uwpl6FZEg+BoroLT+MMuvrrCOz6X9CHOUPhgx+bw=;
        b=b/owO1Y4S3ebcpfyq0RfreZqHN7FbyKAGiwfFiRyGtZNAAfQmCDhj0QvAm1iewZEQc
         OiMIiyfYvfFwbgNBY7mLuQjRiYhOYsGjGQgZL0Dpcjtz6uufk6Hme+E1zcXeRUbWoOI3
         fGEFvfW0t5AQPcMLFawh/qhNAFm0ZmfXwUpLIBammCH95IwS19iCP8HWwVbrgxlKkWhf
         QYxQk26+1TBFg1vHkYUSPccD0pnKRIzLcE8wONQHJEnsF+f9nwlGrKWjEV2jtBYVXluE
         kta5T87N8M2YrLHdvbS5hLTG+z+jV9C0SPu5vqPWeNdmJC6b8zu68DWZWZNrhhur7Il8
         ONtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616896; x=1718221696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU3uwpl6FZEg+BoroLT+MMuvrrCOz6X9CHOUPhgx+bw=;
        b=VShpiw+wbehSsQQs1nbIswwHGAVRoDXt5sySdKu/Z3QdPzL36SwSWronYpXCAISPj6
         h3mrv64BfwC1B/HMTOkF3PJ22hv2YA59Cuq0fwWCz9zw7RbOuSQNAuo8D2Nf3EXs9BQC
         xcfo2bERLG15r3q0ClNasN1u2Zk8rsCJCKzB40y7EPHa+NDWfI0c31L2NqlBF8Xe8Pn9
         s8SdBYOA25yDEfC9Rain/obokYHr66+tBXGinyiOzxa6GIIu+SJo6T6P0sCTLb3gYEgG
         Dm1lZt/Vs5VtRMkH/ppWP7NSjB3s5i1PCCj9YvgW8WmMoUDVuq49IrxZSihxubp/8oNs
         ShVg==
X-Forwarded-Encrypted: i=1; AJvYcCXg1kCO3MRqGO+sL38OK+A7tR117G3/c6nnsi/W+NSNmoAhSa43Rri76fIPiD3sUlTUJ4dxUO6U10sRQoG2rT9JqpFiIaeDgyU9Sh988ncGnLRzRytGEzctRJkcQob88AKrkJHzW18s3A==
X-Gm-Message-State: AOJu0YymZL1QcMQbzlpCWBmKd1Nobos+668nLtKJVciTFGIlxfjfJNiZ
	bg5yDW1a1Xyes7TGST1SKRUDTGLGN20vZ9H1TaCXoSsZwYisXv8q
X-Google-Smtp-Source: AGHT+IHJyIVbp+/t/uUASPMkEhex9c5D5c9PZiZ8p31InviasWOULkMlU+EQeYeS+JOHRk4WBy1BrA==
X-Received: by 2002:a05:600c:1988:b0:421:5329:20b with SMTP id 5b1f17b1804b1-4215634fdffmr27732715e9.33.1717616896380;
        Wed, 05 Jun 2024 12:48:16 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215810826csm33780565e9.17.2024.06.05.12.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:48:16 -0700 (PDT)
Date: Wed, 5 Jun 2024 21:48:12 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v2] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ZmDA/HLMi8DWrgCk@andrea>
References: <20240605134918.365579-1-parri.andrea@gmail.com>
 <037bc316-3e8c-4748-bade-ffdad4239646@rowland.harvard.edu>
 <ZmCXwjX/Rx7zKWpj@andrea>
 <010bd7e9-de81-4ff7-8532-18c41318123e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010bd7e9-de81-4ff7-8532-18c41318123e@rowland.harvard.edu>

On Wed, Jun 05, 2024 at 01:55:08PM -0400, Alan Stern wrote:
> On Wed, Jun 05, 2024 at 06:52:18PM +0200, Andrea Parri wrote:
> > > I wonder if we really need a special notation for lk-rmw.  Is anything 
> > > wrong with using the normal rmw notation for these links?
> > 
> > I don't think we need the special notation: in fact, herd7 doesn't know
> > anything about these lk-rmw or rmw links between lock events until after
> > tools/memory-model/ (the .cat file) has established such links cf.
> > 
> >   (* Link Lock-Reads to their RMW-partner Lock-Writes *)
> >   let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
> >   let rmw = rmw | lk-rmw
> > 
> > I was trying to be informative (since that says "lk-rmw is a subrelation
> > of rmw) but, in order to be faithful to the scope of this document (herd
> > representation), the doc should really just indicate LKR ->po LKW.
> > 
> > Thoughts?
> 
> I agree; be faithful to the document's scope and just say LKR ->po LKW.
> 
> Were there other things like this in the table?  I didn't notice any.

None that I can think of, the others look good to me.

I'll do this change for v3.  Thank you for the suggestion.

  Andrea

