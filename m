Return-Path: <linux-arch+bounces-12499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFDAECAE5
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jun 2025 03:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BC41899F14
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jun 2025 01:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24D523A;
	Sun, 29 Jun 2025 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K528Z82D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130674086A;
	Sun, 29 Jun 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751161686; cv=none; b=OBtjD2yT+aob0Qrrd07+r+uXlLfM6y78ukt3rseVCUZghJmX7pYm05UBmMi9JxKL8emnwrPyr8XWYfOpR/9EpPuAUcvPP0Z6naxic1HO6Tnj+DtFOeS4GOLGD8O1hCUjdWW+vx96EgZW9QzYkkT8Cdiu83bhG4d9elbubwEimWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751161686; c=relaxed/simple;
	bh=v15j1KwMdz9N6NoLyXBnqiQq6iRz0v59l2ECH89KAr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5/OnAZHfL63BRXAp+ilZZADAY2c1fI0z6zlpMqNRr2DNq/6dHyTAdFwOz+hHT1xn6SfUFxlaFzvgfrtnAj26hipL8Es5gVQkEq4Q/XC+NgUViO4yBuMcSEWinjbvTac75J5z9LeoJnc/mLHsqQLlsFsf3ZCaMiEOkoGqNNs7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K528Z82D; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e740a09eae0so2892800276.1;
        Sat, 28 Jun 2025 18:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751161684; x=1751766484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lDT3P9jNXthcT/eRpPSOP1p81uBOui1vV+1BgbEUh2o=;
        b=K528Z82DU0T8RDFrNi4FdvD2tsQcXEkSYcfQnay37KRhPxP/JBLHYvlCvQ2In79lEn
         UPb0N2q4iOPUFMzTN9FwNizIed1t8hptSJ/BVToC7GhvxcNEwNswGx7BRK1DhLuhlPjH
         E3yvkbMkF4o0vpFs6OnHt+w8zbMfUcj2dz8s/Ic7EKppB3TwIMOM60BdjLQDSkQt2aiH
         m/NETU/mgjWsY/OuDfGNR015E46ayrqeVaWzb6Nq7SFtXlMVOu62m4MgdpZFvEqKmI3g
         4Tz0BEsQzBjG4n1qvE/YxWZkIhY7Qo2+gvGRyrsSu3c6VZz+3F3h/nhT6Oh+P6yGaMv2
         e0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751161684; x=1751766484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDT3P9jNXthcT/eRpPSOP1p81uBOui1vV+1BgbEUh2o=;
        b=cUX82oThjFjeYEuEb+6JYci228AcYjuvpPOhdnClkpD3JCgZ/KATrwjxgbHqzNrYXU
         eubAFzvTwYWUJo5fKg6pufuCSrbgEBufencZrNw5lU5Ika4AxXL+sfMOLxTOKMSEZpgA
         Z/wdrrpPz5i6KWdlGHNBmct7P/jHR/WPKJCWBtam2lC4O5jXB3gRoFYt0roxLhm5YAGk
         K1lJNK7hGMku6Bn6yQ/7wU55gPkWjIok0E0vFCcyKrdRI/bFw4SdNXhs6aPfScNtX7Ty
         pDXx4NUCfPQh6QYrzUQF0+9IKLP1NUXvjFVS3g6huB4pIhibjl8JwTo2S2XjzLdydmXf
         OCyw==
X-Forwarded-Encrypted: i=1; AJvYcCUGDdfqLUMHE3lslILgR6SnmpqEX+OqYcvudms9dYUakAhseLVwfUDGit9mobJgeVH5mW177dhK4o/edsAs@vger.kernel.org, AJvYcCWPP1Yd/9qFuJgHR49O8mTiZamlu9LdyzAQWxXR6HckNizWURQDerb9iRYIBEJiWzVEGBpxbvxXQIr5@vger.kernel.org
X-Gm-Message-State: AOJu0YzBe9dcghtdgA0X162ghzLuNDB27waj1afC/I0JYSFNXVa+R2ef
	MxIkr6S6z7B7EzZtWFuZkFXWQhmmg9tO0ky0+yxTx+m0N/j4mP4jZm+m
X-Gm-Gg: ASbGnctzgLjrwzLtbP5C7nl8kcIgNyn0LcukCUit4enyffZBPis9938Smdk7Gby+b7H
	yZUcx1k/JZ+Aq63+fWsPGl+Wu5o5jqXSMDAyShG5cqwm40tArNWrD2hSTjySMoHSQRW+eURGQJC
	Mdm6iPpS+RWiiMSRp7CaB9ePsFUv9vXKE1qaXbbWw9QqzW+bHnH8qw/qqIbWqlNUec4kGklbCIO
	FjccBzjWSTBrQxdszSKkbw3sgtNsrA1VVYHWWxgOjy+/08s2REJ/g86wEc31/GE186KBleQv6JL
	Ag++LkhwrT7gW8wFVhtFVRWSCMFRgX4rqW+Zg4r+hPKiS8Lk6U+0enGoMsBWb7WlzVGnZtBuFjb
	xvTBrNdGWCNlYM8x+IjNF1w==
X-Google-Smtp-Source: AGHT+IH4TLdAYIsHiepvr2Og34KFXHu8F1zJHY5NzzLF3EuhS8CAS2k0zjoVIZ1RY0JMNPJ8L2smrQ==
X-Received: by 2002:a05:690c:3506:b0:70e:404:85e5 with SMTP id 00721157ae682-71517160c96mr155811537b3.11.1751161683934;
        Sat, 28 Jun 2025 18:48:03 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c90f5asm10244537b3.57.2025.06.28.18.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 18:48:03 -0700 (PDT)
Date: Sat, 28 Jun 2025 21:48:02 -0400
From: Yury Norov <yury.norov@gmail.com>
To: cp0613@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <aGCbRguHwFY372Ut@yury>
References: <aFWKX4rpuNCDBP67@yury>
 <20250628111357.1627-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628111357.1627-1-cp0613@linux.alibaba.com>

On Sat, Jun 28, 2025 at 07:13:57PM +0800, cp0613@linux.alibaba.com wrote:
> On Fri, 20 Jun 2025 12:20:47 -0400, yury.norov@gmail.com wrote:
> 
> > Can you add a comment about what is happening here? Are you sure it's
> > optimized out in case of the 'legacy' alternative?
> 
> Thank you for your review. Yes, I referred to the existing variable__fls()
> implementation, which should be fine.

No, it's not fine. Because you trimmed your original email completely,
so there's no way to understand what I'm asking about; and because you
didn't answer my question. So I'll ask again: what exactly you are doing
in the line you've trimmed out? 
 
> > Here you wire ror/rol() to the variable_ror/rol() unconditionally, and
> > that breaks compile-time rotation if the parameter is known at compile
> > time.
> > 
> > I believe, generic implementation will allow compiler to handle this
> > case better. Can you do a similar thing to what fls() does in the same
> > file?
> 
> I did consider it, but I did not find any toolchain that provides an
> implementation similar to __builtin_ror or __builtin_rol. If there is one,
> please help point it out.

This is the example of the toolchain you're looking for:

  /**
   * rol64 - rotate a 64-bit value left
   * @word: value to rotate
   * @shift: bits to roll
   */
  static inline __u64 rol64(__u64 word, unsigned int shift)
  {
          return (word << (shift & 63)) | (word >> ((-shift) & 63));
  }

What I'm asking is: please show me that compile-time rol/ror is still
calculated at compile time, i.e. ror64(1234, 12) is evaluated at
compile time. 

> In addition, I did not consider it carefully before. If the rotate function
> is to be genericized, all archneed to include <asm-generic/bitops/rotate.h>.
> I missed this step.

Sorry, I'm lost here about what you've considered and what not. I'm OK
about accelerating ror/rol, but I want to make sure that;

1. The most trivial compile-case is actually evaluated at compile time; and
2. Any arch-specific code is well explained; and
3. legacy case optimized just as well as non-legacy.

Thanks,
Yury

