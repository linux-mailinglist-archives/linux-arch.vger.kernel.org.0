Return-Path: <linux-arch+bounces-15430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91016CBF548
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB07F300EE53
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88F3246F1;
	Mon, 15 Dec 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWcISiYv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62935309F1F
	for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821584; cv=none; b=Ky9tQw5Vybma53K0r+HGvNgsN841hv2crYnwCVz4f8FI0HLlpC0VfgtJu7eAoAaDRXcZ2MydBjT8xajJ5QTwJIuhBGAGaDOT41hSrEDtzpPIzzddtamGU2wsiHNj0z3ARuYD8ANPX4KAwjRQMwB0dMJwJOx5dO2qq6NVBpLRge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821584; c=relaxed/simple;
	bh=rKVKnsmZY5Zk5WseCbLhC70tZU73oYSI0ZX68nvqOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgNhlcnxX4w4PKrkTVsnYceKQ+eF4/FTUHGXa8VgEXtjjYWOjMItBIqVO9PKMlCmVTbGcxGPn4/6uUA3fZkIYH+4BCrSmFiN8JmIntPoaM/wSmcdyzSFHt86DxXlRpO8A+AINXOzdhme462ISn4ZyAdO+QkwwrDaZUhVlWFdkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWcISiYv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so4174751e87.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765821580; x=1766426380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=mWcISiYvQDMyWrcSRycAfbgC2LcfDHeiHNEwlrIHZIiej1AYC1xSGsNIQAQ09hrYkV
         JX5RKvAXPuBpvT42pleeeJWKLBH2sgmOEqfv/KpJmG2j4MZwEb/VhmN2KUWZSKmpR4y8
         W9Y9TRYiK/LUJSWBxJeCtVm6+grs9CMML+9OjkE4C8237semIawFtJN/0+n1tfa/B4sH
         4PXZxM7CBczsbeXD5LrxS/cB7X27CZ/SgFLeQqgNRSooR0u6fqf5viqD1bfmET98d1BJ
         y+OTGkBGOVpj54S8EoEEBS6SOazJkp5BEh/6fqKDGAxYCvW45iAXLY5VypDKgUjIZ0ta
         NCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821580; x=1766426380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=eKoCWSJjpPg4Hu/qrcGgIRgXUEunSEK6Uh0GpRmFgHPYVdc0gq7CoA/TOSX6+vskYX
         Hlx7n90l41xjAh0J3aAyPGYnhW9qSyQxYgcLarlUvoWV4qHag0vv8gLgckdrcgwfIkqs
         rDfD/BFlX8MnMyyCfrIpCiYo8EtZHD65HbXNcQwpXSbFlREnzBMOrj7M1ccNMydvw6Yz
         BWoWvnBP/WBFrOg5vNt0M3eOm7OKAgANvJze5urCy4JUEr00TaXA4hh6CmHIBGw+f3xM
         4zkVtdMzGsk96/7Gt7VauDnhj6Mak9Ig/7dWZXwF1p0Xmas1seYqYvq2NKicxfHggnwF
         K/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5MxD6Tng4MSdb+hln36jy9MbmVjfOiU84HotILsz2dwxp3wGNOYlKVvHfZXu3RCbk0vj0phTV/7Q4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49kWZf1s3DPjvo/r82/m8zxS9r8+/6ky7XOhwHdHgghAmDvZk
	TTV+CZA5cXVQGcg8v236CKr/nkfPlV99ACAGr3T2t0BxDtLDuAL7T4LH
X-Gm-Gg: AY/fxX7V0ZsxNx5vzKlQorqNJ6muxcm15wBnYycBs6MHApSvJn4erQkBaYVqlTVfsms
	Jo8pFK798ZguNlfkXAOBNbRDzUVEJJYp4gVhV4lKaail4lw6OCrFZp64cshpAXGj4zNt2xheBYx
	aukOHK2A1Pr06a1//KGxzKhMB7sr4iIBEKnHPwJYfMqVJaapzM3jLinuEqmRnByGBsJLI/VesE6
	TRJIpCtgZ35vBzEqtfRVd/5hORFd21oLy5do5q5Z8DXIY/k4HQ1KXYsb0keqjXy3/Rq6B5jBlFX
	ibUwlVvexjj4akwyPl0dCIgG3ZCD3hnjQ52ue4ef/6krQvy/HcCZNz3OFzRri+k5yQdMhkMFTQU
	C8sq8y1s2uOmhJrbb6KWkBHQZ/fYomHS2NXvxRFBABjBXwakuqLvyucKNlhbUzJrItVDyiAgmj/
	alW93lDJnb
X-Google-Smtp-Source: AGHT+IFsDUVoZATaLzj9N1/hjfRE03GZ2gIP+Qj4HQeX9tt2ONoJL779FMDFpau9DQULSPR5u/L2Cg==
X-Received: by 2002:a05:6512:1154:b0:597:d59a:69ca with SMTP id 2adb3069b0e04-598faa4d5b5mr3889154e87.28.1765821580147;
        Mon, 15 Dec 2025 09:59:40 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5990da11dbfsm5648e87.13.2025.12.15.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:59:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rdunlap@infradead.org
Cc: initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Mon, 15 Dec 2025 20:59:27 +0300
Message-ID: <20251215175927.300936-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
References: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Randy Dunlap <rdunlap@infradead.org>:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you!

P. S. For unknown reasons I don't see your email in my Gmail. Not even in
spam folder.


-- 
Askar Safin

