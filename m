Return-Path: <linux-arch+bounces-4959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8690C890
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 13:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA924282CA7
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E663F1AD3F9;
	Tue, 18 Jun 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz/JSy5G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786A1AD3F4;
	Tue, 18 Jun 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704451; cv=none; b=M9M62C5zSdnLV8TS/KH+a/vys+ga6a90ofWX20yW+Z0c01EFIQhGEDvkXB3bWoRCFx+xbpvHtUk08lNA5YX9gIgCLJ9Lb6h+7Y/7AszrMH8cyYM4GYIFonAcBAXQTUPyxut3A6a9l7NAoa7AMYwQbZ4NWxa9DKPVUE6BeNuWQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704451; c=relaxed/simple;
	bh=p8L2vzOMz+sBpJC5FTUEffPN0wlBLqjvc9zyZPCjv4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKWw35bihV63nhQ5qFaVYzCPNIJXoMzepG1E3qNhhUWGf+1LnCGrHaYkfucSzeXPyMgr1gW+KioPmjSUzEXFVpyzGwOuMFcKOw9KMohJ685UInZQ2TTBCJzSOygd9bb48YuxyJjLTUrhUmAGBkZPA9K0cosE5QHVjqIKsRIujbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz/JSy5G; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so2138266b.0;
        Tue, 18 Jun 2024 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718704448; x=1719309248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPvQtRBNrrcMRsqP2MYe+em+927b6xZ9L6lua7JtbPI=;
        b=Rz/JSy5GpNLL0VHI3aVl261BKI9wI1u7SoRR//egbNiZ+/dx9eiK0CbI351hj1vATs
         +FKt3u8dcaaEZhy1A/rooCcto/t6aEzJcJoms/BXhdyyXhxYMSBXwkeUW6+BBNAOG2ie
         iHWfWgBa1O2FUhbObpre4WmmOXvvHa+wz7Pw77nC+ciLBAlE0glWdK8qh211QjHM6RvV
         nynb/vqL25WYuBs7XjRpusMAwDPOsPTsOUBIEyFrvW3Di7yiv2zWcqbNgYnIDJj8qp5j
         tL9R8k+0w667DVDHsrOUdZsdZVK10XKEIvbceb6Q4C2a1h3P+VvdL/mvS0UotOM8Ew0S
         R3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704448; x=1719309248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPvQtRBNrrcMRsqP2MYe+em+927b6xZ9L6lua7JtbPI=;
        b=EP/34knSpRa9+QhYX7VYS00SgTW3Llxm+nVAvxlYliqjPhKXdVwYJW61zeAlzboOA6
         JSJbKYIzzTZ90pUoeNwj+7DfVjosxNa+gBdOMpGCwP0Cs+L2yXUHcCpKDv8WQoAgo3DE
         34LKOaJY20610bBJ2SexahQTpaWiCWQIp6DtQxHY8T1LdOaB9JB/8Oaotwc6DYQh8wNr
         e55M4YurhYTv9di3cJYUY+ETypb2/QmlWKxt5ErCZjLGujmaUc91pBat9AQElFXs/3x3
         TWaIIf1NABe+cyjpnYmPRDTzAquPLdgaGZw7kCBG4vRL0M+2tW/eXyAK001vxL/96zz3
         RgIw==
X-Forwarded-Encrypted: i=1; AJvYcCXiFc85b0c2gqbSis5dPqXBdMRQDVTRESK+DWdbAQBylpehaGRYFojWSRMRmZ84kn17goIbm9MoWpDaxtYcEBDdtutiaV8RaYujuzGssGJncY+VIFaz3//V6Ndv2RuUD5baTeG5Mz5a7w==
X-Gm-Message-State: AOJu0YyGt4zcIOp1tz2cKnPEdW+YKM/YZTbYnsFOhUAmW8te3Enzk3TJ
	j+yDEvWVh6Z/bNPCugf8DkXCnbBUE4iDccQfhtPH6Famx1Rtvhth
X-Google-Smtp-Source: AGHT+IE+l7bzaPc5fQHXCTtSV8nARCcYsskexzx9+iXNAYbgOuJk3o1PI/j9+1XCmMyFPwtDRidSVA==
X-Received: by 2002:a17:906:1405:b0:a6f:8e53:e981 with SMTP id a640c23a62f3a-a6f950545c8mr120854466b.34.1718704448266;
        Tue, 18 Jun 2024 02:54:08 -0700 (PDT)
Received: from andrea (host-79-51-73-205.retail.telecomitalia.it. [79.51.73.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f99a09fe8sm53893566b.9.2024.06.18.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:54:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:54:04 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ZnFZPJlILp5B9scN@andrea>
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <ZnC-cqQOEU2fd9tO@boqun-archlinux>
 <07513d65-386d-1bfb-f5ad-8979708d5523@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07513d65-386d-1bfb-f5ad-8979708d5523@huaweicloud.com>

> This follows from rmw \subset po. However, this might not be immediately
> clear for the reader so having it explicit is a good idea.

Sure.  How about as follows:

diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
index 2fe270e902635..8255a2ff62e5f 100644
--- a/tools/memory-model/Documentation/herd-representation.txt
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -14,7 +14,7 @@
 #	SRCU,	a Sleepable-Read-Copy-Update event
 #
 #	po,	a Program-Order link
-#	rmw,	a Read-Modify-Write link
+#	rmw,	a Read-Modify-Write link; every rmw link is a po link
 #
 # By convention, a blank entry/representation means "same as the preceding entry".
 #

I can respin the patch shortly to add something along these lines and
the collected tags.

  Andrea

