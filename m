Return-Path: <linux-arch+bounces-5916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F617945B55
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B38A281574
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6501D0DF6;
	Fri,  2 Aug 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Lvqibp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451C1BF32B;
	Fri,  2 Aug 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591989; cv=none; b=paL4chfMPMp5VWbTMUKXcZjcuyL26B01SqkJ4YiYCFHhUKFn/x8ErWamIv02BdhQFyeUEUf4h7fRc1WlRe2zyOlY45C51yVXXEMu7gvCuZ9XXcwHTmSeMOkpz03iz8ChRY194EK/EjdmSGsImKQeE6FHkV5Pl3rj9nO5BNF/aDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591989; c=relaxed/simple;
	bh=r+CuKV0BtJAp/fMFn++g/APZ2xgoalbuTBMWgFPMv9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9hQb9tL8wJNxp2t7q0JLyWpa6uj492L++zYLGNdKSMi/3TgY9Xzfqs8xdS6FAPR0fVaZbZoRJpPdd3i5W1Zgc/Jkl3bTabJMUIQoy1fiZJm5TJ/rhVx+oM40fHJPlXVT134nDC91Ucf2X7jq3JSLjW0iakyC2vpW5JcULf5Zgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Lvqibp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so49610815e9.3;
        Fri, 02 Aug 2024 02:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722591986; x=1723196786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q67BM/SyptRvsJWIM+wuVI8aE85d1Z8XEHPF+IhIGiI=;
        b=K2Lvqibp59XTun7HLk+FkLfU7HXYM5cbgwL5ynUsAc47kqwX21WjexcA2b2YTUd9Lh
         5CzeoI8JwTv5KjsiETAhTt+7HKWPypBCIwMACr7T2TN/+Yoa8QRbPGSOKghq4zHKWfRC
         IahXcwKOniF0D/d1VRmVbUfwYOA90w0flKUy7xiBADMxy1/2limlp2wb+wi/glsUnj3f
         T88zgOp542EHP/q/7m0Nxu1l4c0bJrrgUGAQDUD8WnDnZvVC6vMmxI1eY9LKnY0iy5tX
         VeVv/8TGLxtFnNfnFVV1WQWe4sBcv/u7p0xiMY3IwF07zvc+wiWpObcWL3g+oLg2eLXi
         TzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591986; x=1723196786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q67BM/SyptRvsJWIM+wuVI8aE85d1Z8XEHPF+IhIGiI=;
        b=litUxoEkN7s0KrKYhhdRdYXToJZRVdAl8UDNi5Ijj+W2Aamy7d8itqhtUAubDX2KZ1
         fooazsdJ4URzfep4bdXcGdLo+ERQNWOqvS5V/o/mFJexKvOXvXulyh9gr8VEWuZrrN8C
         1H9UeUsSFjPCBWYLBUgj2jKYPzDpNpxhz9Kq+johnfp+xRl6hwhoctt4CHmmkyU2q7eD
         +AmKQw4puvTC9dIhtf4pepA46NY86pu8Z14zpbpam7LdFPOF+0Wt6sC1KJNn6LZo0Ika
         M+V5IiP0w3A3ij7tdXru7dNrCxceFNvZ9cy+SQRdCMbNiADoWj56PfUjb/b/M3Vn94mS
         7Epw==
X-Forwarded-Encrypted: i=1; AJvYcCVbn0KShfi0v6nJsdrNgXqerVTD5YwXWGzcMxNMEa5DzCIOa6aOj2MDs56rp1e2Iorm7i+ezybgPRz6n0ZJfErRPYNrMoTNBDLYiQ==
X-Gm-Message-State: AOJu0Ywb3orxpaNmOSRTzJLJ0V+ibELPdZxR2nMYUZRow9mFiiYUL+Cx
	by1X0pi7m2Cj+sRG0D8pVdG1QfDwZXQ2A6Hr4EZQRd2R6aa0r92UGdX3usaEfmQ=
X-Google-Smtp-Source: AGHT+IFCLBjPsFTWDZkjzm22AGa3mLr/3SDceOhn+SPwLeYiThM/NnCa7DDCeZhNCep2iLYyQ6EoVg==
X-Received: by 2002:a05:600c:1906:b0:426:686f:cb4c with SMTP id 5b1f17b1804b1-428e6b96b3bmr20772425e9.32.1722591985295;
        Fri, 02 Aug 2024 02:46:25 -0700 (PDT)
Received: from andrea ([151.76.3.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42824ae7a59sm74389155e9.1.2024.08.02.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 02:46:24 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:46:20 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org,
	stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 7/7] MAINTAINERS: Add the dedicated maillist
 info for LKMM
Message-ID: <Zqyq7DjIrHAOqf0k@andrea>
References: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
 <20240802002215.4133695-7-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802002215.4133695-7-paulmck@kernel.org>

On Thu, Aug 01, 2024 at 05:22:15PM -0700, Paul E. McKenney wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> A dedicated mail list has been created for Linux kernel memory model
> discussion, which could help people more easily track memory model
> related discussions.  This could also help bring memory model discussions
> to a broader audience.  Therefore, add the list information to the LKMM
> maintainers entry.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

