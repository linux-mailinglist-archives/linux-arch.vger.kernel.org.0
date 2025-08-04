Return-Path: <linux-arch+bounces-13056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698AB1A8D9
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AA21826FD
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95572226D1B;
	Mon,  4 Aug 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTRrRQEk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1880B;
	Mon,  4 Aug 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330679; cv=none; b=HchaPbDWorEI31dMrU5cgYyce9Q9sqoRWfcwM12gzMZ5i8F6TMArevrMHH5Hz+QwR/jUQFMHg5JS6ptBUPciQELjzKKxUmT/zW+UwtxDrwGAv4Y8rrNc7Z3HzsKDFTdetLd9R4fZ4ljwWH5Oz2HWw4fjtfhxSAxLuhf255Aln3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330679; c=relaxed/simple;
	bh=Sv9e+B0ku9gY5sVUYkdH8HfotPjkdOsfxA1xJ/ShWLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQIedXFMNw+0sSLOkvilod391jZV4t1r8JivEYDBYTD75c8qitwp4laKlxnU3oucWsRI0BimI8s5JunmewtrpETT/2aibj+aqWvT3aFHqSpOE2rYnYUo+9e7SuE8ZdNSxauodR87hUeltdlLpSQGokdcXDplUFJ4Sh0d42+f4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTRrRQEk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458ba079338so16517015e9.1;
        Mon, 04 Aug 2025 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330676; x=1754935476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkoIzvdbgp5UJDKD/3Pm+5aH5IwjTEbJWrEyOw0vbJY=;
        b=jTRrRQEkwKzxfQHgOkjAZuk/0oP188Y3qXrN8o2ys0uEuccCwP5hu1u+f2xcGbZDUW
         4Y2GzD2kf+HrK0OzLVzcUsq7hXvh+tA7tm/ds+8Cpi2e3JMoN88e+9DlFBZFRM94Q7u6
         eZasYYiSsr5DyuofZfwGAfsVGqgd9BK6foUcBAAQFjVb7cwu0mjInwKefbgSHZv5lJC8
         iEGtM0TVdI6ywu01NLJE9Wfvgys8WcoLrA4z2qHoR5lWLo0jfPKx9Tu4FdFOx8mHsIhs
         7wxhi5UfTEpQOwy+mwjD+bweU1+n/hwdjQqBeLl648qq8V+fF4aN4heDwEidHuT7DIMz
         Hnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330676; x=1754935476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkoIzvdbgp5UJDKD/3Pm+5aH5IwjTEbJWrEyOw0vbJY=;
        b=xE4BKSL/ZstHuXtUxH4dMw6OnStPTeGLE6ov8S+ewwtqBATbzfmjdO6tFnmuXDL+H+
         Q8paXQ1HvbcADZsDBUFXYNreYNwNh24tuwrEL9paJRjJluuwZdwMD5XfnouXENp4jV8r
         YW43EWlcp7Dbrfnu7mJjHsR8lB1hglqpyHCi7WOmINaFp7Sz1Q8kdvmSK4TTO0v71tvT
         XTWU33SdWspm5XxBSywwxcIRXVPtG/EuzbLT1ujOU7IOP96Fen7gxHfsYVdMXG7KuSqZ
         6BZYYmjfwxH9tGAhq5a1VzS/NQsi/SPEXErIrpwJOgg4+Rq04EhEoinN9Mc9ShLDIHW8
         iW1w==
X-Forwarded-Encrypted: i=1; AJvYcCU6xT3OvnmPudgF4L4aFJE82wvd4APlxWtUqguI/v6HTU6q46rSVJOxLiVlPsi70ALJFXJ6KupmwK30hw==@vger.kernel.org, AJvYcCVAQ60mE2iZLHqeDrtHdrVJsfVpCJBb7nyjk6fCqk+LITmVABWfr5/IRZuX3OQStm4KasK01pm4vgrOQeFm@vger.kernel.org, AJvYcCWWBgd5eXPebaK9U0uDhW5MW3B73/v/i/sVO9R9CI8QcAGGNprwkd7P2xr2G58K9UWRdlQcg8aWlBbo@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3pd5Sf+8mBdO3+ofJl1gOvQWF0LnHGC8J3bGzRmn6BDHJujT
	g2AUzcAzf+00LaquK3HLq2GCR/2bwOMPXlbjXxzrwOuxJHqn9VaTZSJh
X-Gm-Gg: ASbGncvH7ILd3Fisdk988i2O2GizQ0I7Ect5Vt3GV9dBZje/HlyTBGhpT6l1G52TfqT
	7PFAhVRwNnejGpecx3/N0e8GJChf54jafA2OyhDGZdonFkOw1Wr38C1tFGWndNgIMtHmzsNVNVI
	Kwu74LAqae/cc3d+ZUaUX0L7hsNnlqN6J+XxwzWA9rqIazYB9hGS8TXyblT2VzxArvUqTRva1Lw
	jklaGdR2ECEnKpo31pMt0uyMzfCk5yDQY8SdJnqQQCcUG3xNecCiBNtuQMpHo14mwk8K1vfllaL
	r7cqLf9Be1+FK4Wt2BuWMKp5DeQc+8UXwxQIKwl2pxnrvKeLBRY30Mn1ZLi62oKzvV8evqO5kOm
	cYfpq+3qaQDIHutyPFrh/IISAFN+L5PfgxUkqXiG43IJWmgStM0RnIMgDbHmk
X-Google-Smtp-Source: AGHT+IFRkDDwV/Uzsc6yejzXH9Z7xTlB2uN1P9jNdiE9FXNaXC7utLQO0U9Df8GxPXI1ptb3vecVdw==
X-Received: by 2002:a05:600c:4705:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-459e0cb89famr4693815e9.7.1754330675878;
        Mon, 04 Aug 2025 11:04:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm16187700f8f.36.2025.08.04.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:04:35 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:04:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Thomas Huth" <thuth@redhat.com>, "John Paul Adrian Glaubitz"
 <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
Message-ID: <20250804190434.1b9f7535@pumpkin>
In-Reply-To: <579ca73e-3b55-4e05-88ae-d7bc192f0023@app.fastmail.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
	<20250314071013.1575167-35-thuth@redhat.com>
	<5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
	<810a8ec4-e416-42b6-97bf-8a56f41deea1@redhat.com>
	<579ca73e-3b55-4e05-88ae-d7bc192f0023@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Aug 2025 10:00:27 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Aug 4, 2025, at 08:01, Thomas Huth wrote:
> > On 03/08/2025 15.33, John Paul Adrian Glaubitz wrote:  
> 
> >
> > So using -ansi in the kernel sources nowadays sounds wrong to me ... could 
> > it be removed?  
> 
> Probably: I see that sparc changed '-traditional' cpp flag to the '-ansi'
> gcc flag in linux-2.1.88, while the others were still using
> -traditional but just dropped it later.
> 
> Most likely the idea at the time was to just no longer use pre-ansi
> preprocessing rather than to exclude gnu extensions.

You also get a change to the integer promotion rules.
K&R C is signedness preserving (so unsigned char -> unsigned int)
whereas ANSI C is value preserving (so unsigned char -> signed int).
Unless, of course 'char' and 'int' are the same size.

	David

> 
>      Arnd
> 


