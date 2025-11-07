Return-Path: <linux-arch+bounces-14557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD6C3E3CD
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 03:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABF904E3FFE
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 02:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212852D9ED8;
	Fri,  7 Nov 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqUXaJWB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF672D7394
	for <linux-arch@vger.kernel.org>; Fri,  7 Nov 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482157; cv=none; b=ry4HXnLGtPZ4kS7tmXlDC4PH1KSxfJmkPsYqBitAlJyToIsaW9K0t3gEYJqz1zU8kpe7FDY9rCDR7b7MMz5qY5dm8RTDW09w+yPeBEQehQrtDZyIDc5+9ZHS86irRCWEm+oAuRz0TygjiXKBnAJ9XBbx6CmNi5/O7qiZgwayCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482157; c=relaxed/simple;
	bh=2wJsYMHByxXf8C901yNivTAphL8IDvSKSXz3egAjoMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDCkozYEMVTDauCFIMuOjv3qkpJJu+lXLdHUEixX0S5CtS/9RTRvKLCN/FcBKOxziuK9c9hQK8QpGPZUYISeHsDt6RPoJl21Cc1UfbtDQVrbZJEFo07KE3mcd1KCoziEUyi+U0Wi4ZW5gSVLMDOLg824mj5VhtWnzi570vvDHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqUXaJWB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7815092cd0bso2753067b3.2
        for <linux-arch@vger.kernel.org>; Thu, 06 Nov 2025 18:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762482154; x=1763086954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9ARDwGb0uPrxOLhySJFLBJZQJy4UrXx7An6ywngF4w=;
        b=DqUXaJWB5PXNmMbZbMmV8yU2xnR+VMGbcSefumrZ2KC0fP4PSExfVQyBH7/dN4XMy8
         bP3JRnp97MEXxuTF9MK1pNo85R2zbXJKuQF3Ki+uCo7FZT8Zk6vXEl2qdn5FC2EP7qFP
         yk/d3OxPE5xIUNnSZ8nX/msDGXjfhRxnAHUXjkZnlHaXtcXGvgjiPX1sv5F4yyvw+DSM
         GUraAmB8Uh7dYG/FU658NtFUownW1LBaX2F8wsByylqGJ/z66YItnMxksifX4KDNRvRE
         kmi8Ivq4cEGkJyq2a/PpZnX3jEgmIxPgGlS/CYYx8uufjNsIcY67wvCvwc/14V8GcOVC
         LHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482154; x=1763086954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9ARDwGb0uPrxOLhySJFLBJZQJy4UrXx7An6ywngF4w=;
        b=MpXoHx1Tv4NKT1MfsXDjjhZCOZfodNa5XYyR6Q1LDUIcJk2HehuOr0PrbzCv1tkYjL
         jWIyuUu1Y/4J+QsMcCNMy8g32fHpbvwyGBOleSrXQCXuatXrBqYxcb8oqWkxADXJat7J
         HopqEYDRIC60Fvb1r8BMYbk9212XRTWJf5bs0OhObobk9Py3IwPETN8tm0iDVPcZPxEZ
         PJsh7M1bWYDgUEyrBUSSYyth84gz6XE8uZNqTBUUEinKuK8M1HhGtyky08NTA+YNr9jF
         AKY4PWovWDK9QLFr2xPoyCzrauGX3XZiCuoxazCcM+sSKfYFbmOmRTPl2Gk881g+nwX1
         CIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlMN1aEsJ0L4mIW598b6TLuUK4JRqnM6ITIE3LW/NGASBp1MeqIS7/mqofgI2ZOM3zesC9fzKpJWms@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2hN08gn0dw5IfIaOfaY6RmTgjlCOMxH195u8J/DTnzJh1MEe
	8S5uS1JWBM7qiYspsWedDmTm7zn4JiUqUOu20ECPyHdPOk5T7pSxiitu
X-Gm-Gg: ASbGncshQ4nDRs9zCelUhMBpLqbiV0vhSyQYgl66vrGP73jPt8YkKYI70t9D35KD9dT
	iuf3KXJN5gqpT+0Z4MCC/NJONFnRl4LmtBNvkzHadKyOwIVZprIBxk9QCMUpQieWeTsH22SbF2Z
	hq7PFQTq5dZuzS7Hb3X+sysHUI8BnV5iAenCL791VFGfFJ1E7qFm0wgfqX6Cjf2xjiL5RYc6Pmg
	9zyF4sGZWlrwOOYarLuI8t1Fqw9L2+25syM/nQkx9MIIqJ9VMWhYcyanNT+BnDWuhSJl8OEWy4Y
	wx4KraaW+KfwRSVgUG+knW6wIWY+rnZ6sM0rkNIGJvcyUTuYQnnsQirJu0IQg8J7nG2eAJnUPLf
	8Yzsx2kQLcCYC+VYRGar3k/iA4s7pLaaJM7qd9REns23fycu35msPfxl7vgnoW0LBSBtr9w4ijl
	a2bapB7UPnPNuc6MX63mceEyJy8oJQ7CFE+6k9
X-Google-Smtp-Source: AGHT+IExkQylr1jShV9Ea1kIXdpiUjvn8t/+xJOL3Cfgf/yFTKueS7J/oTfsuiw/7plu274iEpUp6A==
X-Received: by 2002:a05:690c:6f8a:b0:787:badd:4c with SMTP id 00721157ae682-787c534ae89mr26865527b3.27.1762482153981;
        Thu, 06 Nov 2025 18:22:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5c91334sm1361787d50.1.2025.11.06.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 18:22:33 -0800 (PST)
Date: Thu, 6 Nov 2025 18:22:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQ1X55NjyDU806Tc@devvm11784.nha0.facebook.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
 <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
 <aQumHEL6GgxsPQEM@mini-arch>
 <aQva8v22RVQEgPi_@mini-arch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQva8v22RVQEgPi_@mini-arch>

On Wed, Nov 05, 2025 at 03:17:06PM -0800, Stanislav Fomichev wrote:
> On 11/05, Stanislav Fomichev wrote:
> 
> Thank you for the context!
> 
> I think that the current approach is ok, we can go with that, but I
> wonder whether we can simplify things a bit? What if we prohibit the
> co-existence of autorelease=on and autorelease=off sockets on the
> system? The first binding basically locks the kernel path into one way or
> the other (presumably by using static-branch) and prohibits new bindings
> that use a different mode. It will let us still keep the mode on the binding
> and will help us not think about the co-existance (we can also still keep
> things like one-dmabuf-per-socket restrictions in the new mode, etc).
> 

That approach is okay by me.

Best,
Bobby

> I think for you, Mina, this should still work? You have a knob to go back
> to the old mode if needed. At the same time, we keep the UAPI surface
> smaller and keep the path more simple. Ideally, we can also deprecate
> the old mode at some point (if you manage to successfully migrate of
> course). WDYT?

