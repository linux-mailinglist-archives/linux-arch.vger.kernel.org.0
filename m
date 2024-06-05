Return-Path: <linux-arch+bounces-4714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB028FD32A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C8D2873DE
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C5188CB7;
	Wed,  5 Jun 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in9QSbMr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7415350D;
	Wed,  5 Jun 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606346; cv=none; b=V9sZNrbpjPuZ7xUqSaM0SQTtw1dsafkBFyxLQmX8Bmk44/doPd/5jVwEY9lL+m+/ticq5D2qeOXoh3ZClc4vlUTzJJUlx1XBuMxl5oUFb+9TFXXDHV8UcNezL+BlfbxC29WPH/8YKDjggoFEPf1oJhG1p86F7C3y1bQ5cdHgwt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606346; c=relaxed/simple;
	bh=6xa5CksEJ66cp2+yOjIwYysgzhNcq1hcRJNfpRcM4vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyBIy+4ubm3ErdG1PVWZ/SPrjHXTVyhZAACH4FSqqBDdwo9dR/YoDZNWj8qcvI6Hm4uLA6Z0tzuneFhlEsoSpRc9DiUd28kHClOv/ly+Hq75U6lXF7PhrvyUTwsz8kbnyLmVdtCEb+za6niARGoSwK1XD1ICGt63l0FD2tVXubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in9QSbMr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42139c66027so471855e9.3;
        Wed, 05 Jun 2024 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717606343; x=1718211143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlhpO9wfa7FbzgoWIbb4a++FNynxyceuqt6Ojnl2z2k=;
        b=in9QSbMrxfYmG0hFiIKUaptlO0VaF0OpvGSZTycCYBqjSRWmQ7M9rGy9bed6wu0kqw
         +59n58Hfq0CZFG1k2ZsWvPly6dPNE20eGoyO05GW7cjTN1xxJp92NJRbN6ApmtxaMiJ5
         Mky5JNeDsMyvUwpX1dJWTLsJ4RTFX7QoX/IbAt57L7kme7IYuDgLCraZclexp7IPgLtJ
         QWmRrWZSfH4jZJtpuJsdXwew2FNaY75QjjtZ/dy7xLluId4xj3eZOMZgxNjP49ZYZR9/
         eh5S2GthY+8CzDmL/L3D0L5r3rJ3lqHonCn0UdYqeafxNPOUXqSWX8WM+no0ER8F9VF6
         4BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717606343; x=1718211143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlhpO9wfa7FbzgoWIbb4a++FNynxyceuqt6Ojnl2z2k=;
        b=TViNH6qxetVoZ0b2YB+PK3AyHR5rFSIGg3LW1KEgc9R5DBnG1uh4e/Bvps7wjBkgis
         4GhN79Tg108ppkxLdlqBmUIJMB5Nn7GgbQ9KlkJACOUcw3ydQchws/5xZ9XxAczYIgxd
         fBFoV5YTi7sJS1eMwkGnPA4S00NS1Kh2LxlHjGl1tx5STykKTGTgnRjdfaJ/IMDSEthR
         SQvpRgUOECCxaGm2wlNs1XzeSqK6LBZCtTIIPt+1ExugajrbCUPr7w9TOeoaBwEnUE3T
         I7LTEsMkAWmT+zv9nqecJelwo6qFM0Wjc08yLpjKMFTZIuGFP/OsmgA+qR5K/TogYCn4
         Fvlw==
X-Forwarded-Encrypted: i=1; AJvYcCX3iXv8lV+kg0N9w8o3S5hg31LriIcjrjLRsrXtFH5Q+ugAt45lJPfqSYWB3szqnOL0ZSXiGZ8qN4SoMvZPcb0k1QoxDxHzMosg5iRPf5Qdv7zI+eidh58Yk/VgbFFZrtT71jZv2lzi8A==
X-Gm-Message-State: AOJu0Yxn0NxazqS6kosn8nTIhGLrQjh4bUKGTF8vAaFKUVIzRiusAFmE
	9ESJCncGX3VztdM1kWbJRKQu/svX82lZd9SKCGAeluRjLZRpEoD1
X-Google-Smtp-Source: AGHT+IELzmOgA0NaBUcH45sg7zl+DOqtzWl1Xl8q23k7HVAawJ0lNFtU/HMsFfjZBU/VqkhNYnyJtA==
X-Received: by 2002:a05:600c:3550:b0:421:276d:a0df with SMTP id 5b1f17b1804b1-421563559e5mr23286425e9.41.1717606342700;
        Wed, 05 Jun 2024 09:52:22 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581016ebsm28565305e9.1.2024.06.05.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:52:22 -0700 (PDT)
Date: Wed, 5 Jun 2024 18:52:18 +0200
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
Message-ID: <ZmCXwjX/Rx7zKWpj@andrea>
References: <20240605134918.365579-1-parri.andrea@gmail.com>
 <037bc316-3e8c-4748-bade-ffdad4239646@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037bc316-3e8c-4748-bade-ffdad4239646@rowland.harvard.edu>

> I wonder if we really need a special notation for lk-rmw.  Is anything 
> wrong with using the normal rmw notation for these links?

I don't think we need the special notation: in fact, herd7 doesn't know
anything about these lk-rmw or rmw links between lock events until after
tools/memory-model/ (the .cat file) has established such links cf.

  (* Link Lock-Reads to their RMW-partner Lock-Writes *)
  let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
  let rmw = rmw | lk-rmw

I was trying to be informative (since that says "lk-rmw is a subrelation
of rmw) but, in order to be faithful to the scope of this document (herd
representation), the doc should really just indicate LKR ->po LKW.

Thoughts?

  Andrea

