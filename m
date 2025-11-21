Return-Path: <linux-arch+bounces-15032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61BC7BF48
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 00:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21A023507C6
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C62EB5BA;
	Fri, 21 Nov 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q+tMdxDI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45A306D3D
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763768700; cv=none; b=DnVKzJrOsedH//laY50iZ2ldSXpJXY/14elqD/+KyKgGoFjE6laV9p53PPLNxKTGhdR4ArMv+sy9CEGIjt/xmtW+i4oR9PdI9E3OGGZS++sueN2XEQNhDA5IJOB4iLGgezWhsNZnQOxzYRSrk4Tj30ZBf4AmNyCVmmCtMoW9wuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763768700; c=relaxed/simple;
	bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVmwGWbh/zepG1RKa/GMbNI4DXPMMANdGjK9ys9wZLxxfqFnyZ1ujYJgyD01RjzeztGTTHYFXSBewj1Q2AZ3Fp1d5kKJfYdph64RveoyoKFmUBNXVo7sdf2slMF7sa2rdWyLik9vzCmzCdd4uPjNJE9BLh5YZtj4YXc438aslDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q+tMdxDI; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8823cde292eso26285306d6.2
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763768697; x=1764373497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
        b=Q+tMdxDIkYXfhGhbArV0cRrjxNICLqpDxMfcVn6I12tSlGAKpER9GWu29DpBkymHRH
         8+vkLMXGdoMlRW1a8I3ymoYVhDXsc/zbDPsgk6dDtzh5juXd/l67yjvfrH6E2PCz7eSS
         0MnjazwGK0NRKyGqz2ACeRLGXyKvPtxTJ44QTasOxTfU2yErAHu4Ks44MCuNoubORnaA
         NCszOMN2Fla6VYB5ksgTIT29Z+nNac5UtoL3AGZVjOASPrtxjkUtZa4MLYMQCVpwpWT+
         xGLv13APEgGlkzM7Ys1yHg1j8bxhQAP5ngjohGYQXdfFgg/Iu3KmptXD0DSIe/JPz0hm
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763768697; x=1764373497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
        b=WsfsBk/RS6qhzclgXerjyiV9RCgvYpa1a1nue6QxalzpSnA6X/AyYmwjPPnVOiSBnB
         dNpKZrlOcQxOvArIv2dptZaMmdCNc2A/em8CZrtrDzdnEFcqRsOujrcPOsKUbl9pmUHN
         PO6yT+OtsOG91hogO1v/qZ25WgouJcIMdF4nYclNfLYR87w2q2VYgNu+sYswGujNkt20
         vNWqZLigHxR+5Pu4EwU+P7Lqdg9RB42YSoRdvvQ+RzukgrZi28F9wn2wF6H7XTNEq4c+
         nn57+lkeMXIKcClrMgOCuzCrX1w1dzD2B405pUIyHdsFAc+I1ps3JrXqHou0Ps4yNz8W
         2ntg==
X-Forwarded-Encrypted: i=1; AJvYcCUTN3hsjBQWtUAwY76blGAOktoccIcPGLIxU+HniTCHNoXRAJiWSuGTL7CO1UealpIsX0nnZ54Rirr2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+LzQ6+/HzYUmj6RBLkxMSaHXKeR/R+hZdT3CQeT/Z0bWOXHB
	ADpKWuUxjx/BJb4M1nXWDJb/EIEHQjcF8jpRUaY9FpAvoKldEmrf/rPdBgG2O5tZbv8=
X-Gm-Gg: ASbGnctDo/9FNl4qgaFKc8r6DAhZt6z5hTYtThBW4v3TiszO3zLqaP3jhFF3/eZPTZB
	rrXz6fHj8Gat45f8VpYx+KwyM2uJ6QWPsvXq0kAFElK3RdoszockfGe9l/X/eh1z+RkMbz+gC4K
	L7Nge3eYvytY45DvG6UbwyH3CzidyQuFKYRI9ItNCzDl5h8cNoKRth4arcLjrODcjM8w9DvOkTG
	xeRRtVOT34pMmioM2Ck4LDxv8xNjzrBkVprbnivrF55G18Edmm/ax4ira8n7pIO9cB81vbiq2AC
	gjygXFgBDwHE4DlU7mXGrpqZyH4drVZSna0LGchgscKuiIjpgEXx59mcK5QANLnwwmjZnDdtcZH
	CDEn10Uf7zgtHvgLcA7i2Ml1rF6PttsUaUGl28uJ8AA8dnvU/TvBcWk1LZJi+6QwxvBfNeevlIo
	DAnZV5kInVR7ARK23cS1j+hbPmnzJQT3QYCyUB/XA6g81XRxgU/T6zjVS9
X-Google-Smtp-Source: AGHT+IEos7T2Axz389Mmy3AFU8+Jfh3PFehz2HfOxc6qgzO/Its691H7QS0uM/0VDIYstKPPxEQUqg==
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id 6a1803df08f44-8847c525de0mr61714186d6.42.1763768697300;
        Fri, 21 Nov 2025 15:44:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c32csm48350666d6.37.2025.11.21.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:44:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMaoC-00000001bmD-0arX;
	Fri, 21 Nov 2025 19:44:56 -0400
Date: Fri, 21 Nov 2025 19:44:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <20251121234456.GA383361@ziepe.ca>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 10, 2025 at 10:21:18PM +0000, Lorenzo Stoakes wrote:
> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).

I browsed through this series and want to give some encourgement that
this looks nice and is a big step forward! Lots of details to check
the conversions so I wouldn't give any tags due to lack of time..

Jason

