Return-Path: <linux-arch+bounces-2242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A5E852101
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 23:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C2F1F23651
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797E4E1CB;
	Mon, 12 Feb 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uin792MN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328194D595
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775722; cv=none; b=VDPvdmagZIZGIJNND0vVVsovDScLIiiB8aN4A8k6wyz0a0EE1FZUfaN154HBB4ngQEHpxkWMMMqjLvzAOYbUuC9ZavhSSqyaQ5KR2fIHa5ydNXgCINPvTeSnKvvrX8NublHFFdfouSsI4Oc0a8peEG4CwA9NAW4Fb2+heyPKdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775722; c=relaxed/simple;
	bh=gAbe+DaZz7ho9Xs/O1+sZUd+Q7Ss16k+L7gT59qsNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upOp+tUY4eV4eKn5hRVmTo38Zh1wb/rGRwrSWtg82mRSsmjv4MDtUc8FbUWRcRpZ6FccPkM9lfZBzeA9AOswD5EiDzuh62/jOIsfke4HVs8btus6C1Ntx8saWzGX5XAXsipfYH2nzexTO52+FoEZAYn/GPXmpZbp8CZybG0edHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uin792MN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so4427866a12.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707775719; x=1708380519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=Uin792MNjE0TRZnpj2U2D67WjrUmFSXtD3Q/ir6YODqIQtH0gzeSGrurZHjIjayIsi
         fUxkxJ5uK6DZs+M5lySFGq+r+U4gVbSN+3ER81p2+EVre0TRetvLAC2D1CdQw2jp1Vyy
         8e58BQPUuzuewQz9M2ykJ6QIvxcJoL4zRQ1Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775719; x=1708380519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=NsAysN6Jmg6Gm8ovo2RtfzD/S1xKrZGkXyEOiXe13oK4FImkItXzg/6UzoHyWurooc
         PQA3qtOyXLlhkM36AdoFcel1HCgqJwNszd6N4wnPh0OaDDTy+h9pKK0k7IFaMz2DuafS
         OhM5lHn2TtGMySmALSEoMa4aExwl+b9/doE5J/yEqrinaSCnU/Mwxtl1PXPcv4YFjgOj
         gGslG+HPLvAVcM3ceOzqHhKOicIKJSgCb98Al2ACslKJloWPTLGLrj1HILy40RTJB2rr
         nyOKwxC2hciL566sxcXNCCqTBrPLs9pV7QadpbTFS6UuJMRGehlsjnT2eohrzAJS2J46
         MGPA==
X-Forwarded-Encrypted: i=1; AJvYcCW1OpujIuJNog7RlrBDtBIFHG+iCVSWrWbyoUwfL/K+C784Uzl+T8f3bBOqgdhVNyY1p08/aTddWDxjs1Zut6yjP1V080lf8tL51Q==
X-Gm-Message-State: AOJu0YwYPfedspPclibyxfm2tI2oBG1Ou2xRuOxd2w3xRVWRUzkM8mxc
	Z412BMHwp2xSx6TA1A3m2ipOiNh6hF0/nlCbLDl65Dwtfx35KLzpSq54QVfk0du+stfVr44g05G
	7Cag=
X-Google-Smtp-Source: AGHT+IGoNwK+h7hGIa1L0+EuN0hxmTui/sYN4fg0GoiK8JWdBYSY2cMluzUDpkKB9P7CckEmkQjkLQ==
X-Received: by 2002:aa7:c1d6:0:b0:561:eee9:e424 with SMTP id d22-20020aa7c1d6000000b00561eee9e424mr177630edp.36.1707775719331;
        Mon, 12 Feb 2024 14:08:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz0op9P9om/0Y/foI4XEW0pY4jHdQiVrPQ1xUOxy4+4HHJqUod/dFD0obWspAgF8o6rjE/G0UTPHl+MAXac/A050xp77fac4zZ+g==
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g5-20020a50ee05000000b00561234fa24fsm3120893eds.49.2024.02.12.14.08.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so4125547a12.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 14:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXH19Z8Jsk0HqBXq1Sq1EiUNkQz7QNDUuF86wAxH/AzuSm9vawrWKj79r7XS9WyRqCBUqUGAcEwCMa1IuntxhVmVhi9l2tu7Zzx/w==
X-Received: by 2002:aa7:cd66:0:b0:561:f173:6611 with SMTP id
 ca6-20020aa7cd66000000b00561f1736611mr60172edb.35.1707775717604; Mon, 12 Feb
 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com> <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2024 14:08:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:04, Dan Williams <dan.j.williams@intel.com> wrote:
>
> This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
> and put_dax()", know how to handle a NULL @dax_dev. It is still early
> days with the "cleanup" helpers, but I wonder if anyone else cares that
> the DEFINE_FREE() above does not check for NULL?

Well, the main reason for DEFINE_FREE() to check for NULL is not
correctness, but code generation. See the comment about kfree() in
<linux/cleanup.h>:

 * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
 * kfree() is fine to be called with a NULL value. This is on purpose. This way
 * the compiler sees the end of our alloc_obj() function as [...]

with the full explanation there.

Now, whether the code wants to actually use the cleanup() helpers for
a single use-case is debatable.

But yes, if it does, I suspect it should use !IS_ERR_OR_NULL(ptr).

            Linus

