Return-Path: <linux-arch+bounces-14519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D6C361FF
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D261888740
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128832E149;
	Wed,  5 Nov 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gCDf5z05"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5532D7F0
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353751; cv=none; b=ZQHqjrWoaKRAxp7MMljavSrAbV/axAgSO0nrFQ1vUjG1yQpZ22sVKj6fl0h0JA7Ktl/ikmWhQy9xOtZgDyCRQHNh1k5jMXDlg0AYSEtznBkOoMntwtwDab4ujIKyHaOTSVhJIimEENPgLlE+AMfoWJNUQKofh8LvMB/k473lTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353751; c=relaxed/simple;
	bh=ij2iHrslX/5yNAV81WvwyiP5ZRrrhcDqQSgtHEa9ZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrobb3pDFGpIjxtRmqqUZrYscLHFGtr5w2XuNgpA42b8PtJXhnxaDgSUJD5NMVvhh67YysERw1FEUpWgDtubLdCKVF6hxZEaEkNyf1udN8cPoAzx8hxeTyJ4deGmS4ovHMt8zoc8TSaLCfxHE/Pg+XQKUMpic2Z73f6j/CX65HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gCDf5z05; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2148ca40eso198255385a.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762353748; x=1762958548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCP0hsq/q40gFxNmjoVFcp0QbOx89aTWebuusBQgCaY=;
        b=gCDf5z05uYtlJggKnF95ezS3J3umvz7sQMNDZDnGK8dtKLvayu7kdaLUtT1vMZ6cHs
         1GrwbtfIe7scOFlP2tQeblKFtqfnBbDDvWuaerJCvF4fbX4Iuw1jMMO5qNBS6ZY5ORf7
         wlXA8FlARkhwl3/zBiBwJU4aOeCxfoymxp+HA7s9/gBrOxzS0LNRs3+Mbv6zW6wrbKgS
         Vw1NtjBOiZPKJ476QYp/x9lkuvghR476RYKYUJr6/ygsD+kVyEil9ToZF0qbl82FpAPl
         jncikulGE0TeNC1J/5fCUZfNhIKnf6FldJa+Hdi7S90irvpaNARjjyogJGnYymejeFSJ
         J/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353748; x=1762958548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCP0hsq/q40gFxNmjoVFcp0QbOx89aTWebuusBQgCaY=;
        b=DZZ1G3SCiay/VEE/KgcSNdfe8icW1VCYkkPMAZ8Q3uiF4hJMOQlArr6f/Yho+HOR4T
         /Mk3tLql4PAVZm49vf1gQRfZ59ywP5Bhc6qFoEoqryJYkX8trpADiO4X+lGcXPVrbm9c
         SHNrmfhFxFMflu0MWLqTXX0nMbPV0cyrhRGiR7f+KyLvMXw/ajImqDdcLDgYLWER+z0U
         xkjwx+4MAsnm/62LmjNY7LVrwx8mDy4SFMgZRMI/QUfLkJbMd5BBgW4cpOv8xMP0Q7gB
         bFPVhzUOR0AioJgRNTgwDWMDnyxsLlVHHH8c/dXWpNVs1hI26VDyAi4fha4BYacpjWTy
         /nzw==
X-Forwarded-Encrypted: i=1; AJvYcCWToQ4i0zV/3jyFz1fboSbJv6btCVgZGQN9h8TGJdj0u+mIrDj+sL8Edv0d/9c6MsIV6Ooj3XKcbmlZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWgtONpvfiuXQNO24xcDewFo6pBGwfC6uyguSNlTOnFJdSAt+
	AAAlUxB7xd7hWCtvfkELais60nskO43XzqwTzfdJ3RK8BUo9HELkowIkuFVNt2jD83s=
X-Gm-Gg: ASbGncuMQMqEjWaQyvvMdErJ5U3FrCIqXfUgo8zQLP7vEB5G2mRsEzf5sWsbaE/yS3i
	AOd6Lz6Wg8iX5kqmL1OxX9du219nAXYtwduDI1qi4FObvM904ntOJ3vAS0da6zMzByGR/dRAJBp
	RA7mjsurEOfHUK25y7TPzOxd1uH/Ks41jLDF+7wmx+OZRD4IqVHhgdm4+U4EEvkNJJoNsebEmlV
	C3nzg2zlvBOoOWl/6F9NA+qTgrNAPkCPjsjbK/NyG4/qZx4X4I9aXNYk5TymWfTQe8msSwh81+e
	24GmoJ95ZyEyZBFQ5QYMZ+14BPsbS5lIpb+gox0RssuVbZ4h/WWuJpPKWiLY5KUWlq1P17mvkGV
	J3l6r/HzFJBv5rSuqb4bIFOKRNSpSUQAHQCLUWlJgjlpa9l2qifgKFHTxxaGe2xbpjTpn06QbiF
	8p0U+yiUBdEPclbW1BGzvfv1KsPvklS3UcuMwlHzUA+ZstnuSjqixTrw8ZD8e0lNpYr1Lrfw==
X-Google-Smtp-Source: AGHT+IFOPmymxkVWTStAmI1fSxsEHrX8n+cH3NR2hrKHNMeSwi6zTbwFsDY5mjtR5/Zbzi6pU1fUXg==
X-Received: by 2002:a05:620a:4416:b0:8ab:4ada:9b2f with SMTP id af79cd13be357-8b220b7f441mr375892585a.56.1762353748298;
        Wed, 05 Nov 2025 06:42:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b21fc36dbasm239867985a.19.2025.11.05.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:42:27 -0800 (PST)
Date: Wed, 5 Nov 2025 09:42:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> +typedef swp_entry_t leaf_entry_t;
> +
> +#ifdef CONFIG_MMU
> +
> +/* Temporary until swp_entry_t eliminated. */
> +#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
> +
> +enum leaf_entry_type {
> +	/* Fundamental types. */
> +	LEAFENT_NONE,
> +	LEAFENT_SWAP,
> +	/* Migration types. */
> +	LEAFENT_MIGRATION_READ,
> +	LEAFENT_MIGRATION_READ_EXCLUSIVE,
> +	LEAFENT_MIGRATION_WRITE,
> +	/* Device types. */
> +	LEAFENT_DEVICE_PRIVATE_READ,
> +	LEAFENT_DEVICE_PRIVATE_WRITE,
> +	LEAFENT_DEVICE_EXCLUSIVE,
> +	/* H/W posion types. */
> +	LEAFENT_HWPOISON,
> +	/* Marker types. */
> +	LEAFENT_MARKER,
> +};
> +

Have been browsing the patch set again, will get around a deeper review,
but just wanted to say this is a thing of beauty :]

~Gregory

