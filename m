Return-Path: <linux-arch+bounces-14247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0673BFACC6
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC9D1A04B67
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 08:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66901302141;
	Wed, 22 Oct 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUx/AVC/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232DC3043B0
	for <linux-arch@vger.kernel.org>; Wed, 22 Oct 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120398; cv=none; b=RrGHeF+AIrYPwMA+ZC9F2ZJU7OQrUgMqQktQMqI77qKUWzcIC4OExf3Ozt4W3rVq0TSuBVHt0k+bDJe7WQzJ0RAW+SF4CaCviemSxOoQrVnwj4r7DLf76kpXxXBetu+QzcSkbBVFo0R9nYY6Dc0LQwvAw+nUEHSOxZpUK0C0lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120398; c=relaxed/simple;
	bh=eyBdO2wWOgqsPzs2lpBJ9/L31r8e4dCSgvgCYmxIx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF+eOX2Te49NTbhe+bUrxh15xCcrcw9zz0TBaOpYtLc0We1fbTwgyZMMzbtK6XysROmX3TQb2h77OuMx1irwc0Q+V1gINak2RkyVgELGfpMr/8min4OlvPdc6siiFMTdfFEgWY6fSSIFThBTeoH8p33iZFcNEBThl+KNRZ2jTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUx/AVC/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso11112150a12.0
        for <linux-arch@vger.kernel.org>; Wed, 22 Oct 2025 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120394; x=1761725194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=aUx/AVC/VZbpE2oN97dtsPHXthi3yMi5uzy00pyB+I/2aKpB1pOF2pRPdY6cZntp6p
         +DxMKa9u/iHSxDOYlybze4ivOTbEBXwIlPobhtH9vR+ofclCSVUnFdLZ2x75oKao2T6F
         BzGLltxDdG1BTWxSKuNX4gqbmqd/hSjjIIFVs0n0Ch4mlkoUiC6dBoLKKuDIBPDKTFUi
         kFk5uj7UUBrRa5xQZqggiEu3sdLoHgwuGvH/67ISB2+jrRmwVgOB6jqYyuXpupwhrpaf
         63/jcsA3jGWujqwOZrdyACWvjfRvauXk4GbFXeQNuFeYqpEhKr8/+iUckaeissAGe+rY
         jSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120394; x=1761725194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=WJDISSx3f8HJ/y9ZDWyMQnSNsyNxGIw/bfkRsW12ci5eHcujYrEbgWvWZ1fqfUCOuC
         mlQUP+i7UFACdj73XCtdKnIHmZROspC11u8sn+W+sJbt0ThNQj49gu1Ti4/hzmhcN5Uq
         AB7ro2Fh4bg5Icw85EfzHyUmYCGu0+Zst7488XRk/rqyrrcgeCzCuwWuUXCISoYMdX+K
         3g7LXC80nMk0QcCjyFjOx68LySJcovPo1qTnh6Usyk2bXCswKufKLTPKdYaBGdavB7fE
         C2XlsirWSjgQwHJ+rzbi3kDWzz6IxBRmNOYkE3mcK/wUPpHVVcmFoxplINilGmiq6z7V
         5xNA==
X-Forwarded-Encrypted: i=1; AJvYcCXVUu1lc3eC1RjJ3tfjIrlNIY4HvlhNTf1UHIPVxng0n5Re44h1dk9hV4CBCZ977dlVJoG1z0g5nFun@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3rcO0YGL7xy+bPcd0dPq9zL4yLtsuubwzin9AhzcSPU8ZXlb
	6SwuasSwEm8W+vZlP8Vf8LoaPBqJxyrDd/NJ2fh6Y1v8fbTSPUX96f3T
X-Gm-Gg: ASbGncvvDc3tnlbH3nbf0Gpo/+uY3E+wGWiuyEKwfAamfhhEZzvhW2Ii610tx1iG+pi
	hmpIzjfJcYdl/aV7oBdPqFGROIJY/qdTNmb1kwAvu2mpMairyVKH1XQVTiqZJes6SS7YMqq+JlP
	eDLBDbMzJdx3aiD2ygynvhchc1FmKEHNrpiyLcMVoRU6EpZq9FsWa1Hfc6T2UWGFSHjrbg61+56
	m5pJWInNO31TGeRo7wJWX3kQ7/oKlk77by+hAmtCx753rHvfZ3P9ifrYxwENij9EMp34mJuetij
	aVJghVWxuAUCCzNQXG3EZrooTccKUAx0dLPjIJXP0FWCRwXzBkNR2R5WyS2xGT7MOZttqNBF+io
	Rut3yJrK9o7F4BiAITrxbMMxc1a71LoTHrAKHQhMH3A1eTFGPrdHlkWkGXOBWOSnS91ii/GvXQC
	X7
X-Google-Smtp-Source: AGHT+IFKMamBOdEkXZztW4+a96FX3cVQPwKK7mU8xvsOl5ZRh1X2aHXQdNoBVmqwPChAhbEjv7M9Xg==
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id 4fb4d7f45d1cf-63e23c0c43amr1116868a12.27.1761120394218;
        Wed, 22 Oct 2025 01:06:34 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c4945ef49sm11192106a12.29.2025.10.22.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: bagasdotme@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	arnd@arndb.de,
	axboe@kernel.dk,
	bp@alien8.de,
	brauner@kernel.org,
	christophe.leroy@csgroup.eu,
	cyphar@cyphar.com,
	ddiss@suse.de,
	dyoung@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	jrtc27@jrtc27.com,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	krzk@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	nschichan@freebox.fr,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
Date: Wed, 22 Oct 2025 11:06:25 +0300
Message-ID: <20251022080626.24446-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aPg-YF2pcyI-HusN@archie.me>
References: <aPg-YF2pcyI-HusN@archie.me>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bagas Sanjaya <bagasdotme@gmail.com>:
> Do you mean that initrd support will be removed in LTS kernel release of 2026?

I meant September 2026. But okay, if there is v4, then I will change this to
"after LTS release in the end of 2026".

-- 
Askar Safin

