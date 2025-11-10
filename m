Return-Path: <linux-arch+bounces-14634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4ECC49CB3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Nov 2025 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FF264F1247
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2D2DCBEB;
	Mon, 10 Nov 2025 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEGty8YH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EE2FB0BD
	for <linux-arch@vger.kernel.org>; Mon, 10 Nov 2025 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817954; cv=none; b=Jmb/in5VnCVXsqkb/ed8wpOykgBWAmzKkLJar+2blDmGxFa2RHHLjiMcZPEijFe5rZnvriR3BduvHwNCHQK2CAqT3mg/YonoSHNj4JHoXHG2mfjraWGX+1R/hJiTuK8OwYaYgA0ApjjtBYt/vGwh2oj0THU0CJFyXvVrj8dc4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817954; c=relaxed/simple;
	bh=Dn/NYX3Wj4798jgUyiyxe8j2iflj/zcXoK6zpJuJGpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NBOnwYEjSK2ekwtZW27opqSKwC8/aFqJH2CoeZ0uiESMndhj07XNQvm8xstWHoj15WuTDSyeAJed27/K0etVSoA4e9wvTxvx40CuaC1Qs+Sh82ne8T3uChAJyF5NxXnigCSuKU5VAb2fIILT3yjcsfH4wwmMT9jRDCT9YI3scAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEGty8YH; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787ff3f462bso3319867b3.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Nov 2025 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762817951; x=1763422751; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=auOCGMGZsgkQSYvZ+oudFtHe19C6Wc96WcK7gMZx0zg=;
        b=mEGty8YHoT9lQfsMZxDzImwxoSukZsGElucuwailTczNWbXvFVZVaib8NlFztpaXjv
         DINb0HvO59EpPjVQfH0dH4S9w7v5cVqho+oGE80jK/g5WRlAsbjgkFwn5QPHyC8nmK07
         yb9DAiwpQJrZc/sRM2CnfxddXUN01w56nFY8HfWO2EUoGU9B2AAnDCx3C+julOLyBBDr
         h9cm2VEX4KSRyrToAhtT6SMUYjDHt+wAtEhNMLGz+qUy2MiCJ8q18pspYRWMbS2LzXe4
         h17Xk9fpaU8yFq9XP6jrXvmBGM87DwA5BW+gedZmfW58GymS/Yo9xOliYgTr4VWJQHJe
         9OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817951; x=1763422751;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auOCGMGZsgkQSYvZ+oudFtHe19C6Wc96WcK7gMZx0zg=;
        b=HxcFP4m/k2yTrNhjxpCIGZvW0rRO2dtaQ4jypo+0ETsK0JG0KyABf09IZc6mShAH4+
         oztbKvkX8fbMp3cCCAgEGr5LGRgnpjX3ZLua8UHTJli2/jTfvCB2ryHWiMqbhqywP/Qa
         55ulLon/0nxro1pinWK89lDg+Zy5BqCcLDE3aPPOLT0QczT6gkOBGT+KMG0EZ2Xrdl5k
         2pMpHAor/VOyn+zLsQEP/HUYUQQAkYzJSEmd+vY7Gs2/FdLFyqkeECL8cjeIUat23vnA
         oIQOC06u07nO86YkD3Znl2zlxSJhnwsBkIwrYwijunLpeitqmRfK4X/sT9xGfoXxLJWf
         mUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/wv9YR+nZgmShPrBuBXXTOhP64ionr81otzQ8WrUu28mjZc0Xm9VJzm/eCu0X3o8f6fGAQBuOB1gv@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpHl6wTBsS57ePzj11i+1BZEvwxPumUOvDD6FvahpyqsNqLhx
	BujZ0w+aGv/GyJVqnLaZRSDNuB/nHpqLz3cHutgL4i7z+JE9cSwZ7QCB0Ked260Htg==
X-Gm-Gg: ASbGncuciwbw8KhcqV59bXigc/0Rp3u3eOOMphvmMJ4BvgnmlI3c8DxMgJOg1EQ7c7u
	XDrzqbFkRR/axQlO1ZGL/61qGlmVUbSrQXtNXhk32Jy8OhbK2OpWnwT5tM3yFpx+3vJrFlYSYDc
	XW4/xRxCHcONSZXpo2mbSG34GkLGZBPFqiOU3p0LETvgWRyUvLh8D3eLNUjAiRn3tU/bnttuuhM
	d25nQ7i7m5zBxcU8wwKnEoUr0rHULr8+a+p7wSykhmj3HsJRvqKUHzRyN5i2aZs4zy5UnCVepLZ
	bQvFWmP5l8wXQRacE4hSovbl+4TJSoZE2eshOXR1sUVSfzHqf8WxXvTaueD9pKHxOKf2xDXVbLq
	mjnSSe8ukpZy5CWuWWCdSnE8fF7rAbXAW1Cxcw7ibRoXazlmIOyVLra0RwPoBuMCz9fp77bKzs3
	UYqDMsG54FxPsvhuzHJQBft/qeb7WgOSnrHZa4iLC2kAQZPXqZqOiY4GQxmqHRrZ2SP1gUEFINv
	iVKTzQ4Yw==
X-Google-Smtp-Source: AGHT+IGhKzpHrBaCl8nie6rdibzD1wCPS/Sl7zTN9XwZ4g855DlbGN22SspoKQKrIKKHgp9q/nU6ag==
X-Received: by 2002:a81:8a07:0:b0:787:d107:ca88 with SMTP id 00721157ae682-7880355f82bmr9116177b3.10.1762817950151;
        Mon, 10 Nov 2025 15:39:10 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a2947asm27792067b3.55.2025.11.10.15.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:39:09 -0800 (PST)
Date: Mon, 10 Nov 2025 15:38:55 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Janosch Frank <frankja@linux.ibm.com>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@redhat.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
    Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
    Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
    Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
    Ying Huang <ying.huang@linux.alibaba.com>, 
    Alistair Popple <apopple@nvidia.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
    Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
    SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
    Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, 
    Pedro Falcato <pfalcato@suse.de>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
In-Reply-To: <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
Message-ID: <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com> <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 03:04:48AM -0800, Chris Li wrote:
> >
> > That is actually the reason to give the swap table change more
> > priority. Just saying.
> 
> I'm sorry but this is not a reasonable request. I am being as empathetic and
> kind as I can be here, but this series is proceeding without arbitrary delay.
> 
> I will do everything I can to accommodate any concerns or issues you may have
> here _within reason_ :)

But Lorenzo, have you even tested your series properly yet, with
swapping and folio migration and huge pages and tmpfs under load?
Please do.

I haven't had time to bisect yet, maybe there's nothing more needed
than a one-liner fix somewhere; but from my experience it is not yet
ready for inclusion in mm and next - it stops testing other folks' work.

I haven't tried today's v3, but from the cover letter of differences,
it didn't look like much of importance is fixed since v2: which
(after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
not seen with v1, and probably not really serious) soon hits an Oops
or a BUG or something (as v1 did) - I don't have any logs or notes
to give yet, just forewarning before pursuing later in the day.

If you think v3 has fixed real crashes under load, please say so:
otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.

(Or have I got something bad in my build, and will have to apologize?
Or am I blaming your series - seems most likely - when it's actually
something else which came into mm in the last week?)

Hugh

