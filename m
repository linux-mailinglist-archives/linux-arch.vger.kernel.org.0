Return-Path: <linux-arch+bounces-487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEA97FBC58
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B741C20C6E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDF5AB8B;
	Tue, 28 Nov 2023 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gOLpy9oo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997119B2;
	Tue, 28 Nov 2023 06:11:12 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C93B2199E;
	Tue, 28 Nov 2023 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701180671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZslgzkC5KxsP7jHMJfyQVKff23207T2myOVc/HMRlA=;
	b=gOLpy9ooR5alEUjxfM+2syKJDlcrb3FB5iXQd7qKs9JYJFcQmpltz/bEmpMZcZ6R3AK0uo
	Ecf64Donp/eqfIQGF64lFT4dMv/1bhH5kg/T9LU7xZCHWFRUsuvgVtO1yucw6i58Z2mYeq
	YMg7dG+ez05xRcpfxL8in70wUt8APcI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B481343E;
	Tue, 28 Nov 2023 14:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /3/NNf70ZWVIOAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 14:11:10 +0000
Date: Tue, 28 Nov 2023 15:11:06 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tj@kernel.org, ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 06/11] mm/mempolicy: modify do_mbind to operate on
 task argument instead of current
Message-ID: <ZWX0-hEjqkmnR1Nq@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-7-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122211200.31620-7-gregory.price@memverge.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.70

On Wed 22-11-23 16:11:55, Gregory Price wrote:
[...]
> + * Like get_vma_policy and get_task_policy, must hold alloc/task_lock
> + * while calling this.
> + */
> +static struct mempolicy *get_task_vma_policy(struct task_struct *task,
> +					     struct vm_area_struct *vma,
> +					     unsigned long addr, int order,
> +					     pgoff_t *ilx)
[...]

You should add lockdep annotation for alloc_lock/task_lock here for clarity and 
also...  
> @@ -1844,16 +1899,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>  struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  				 unsigned long addr, int order, pgoff_t *ilx)
>  {
> -	struct mempolicy *pol;
> -
> -	pol = __get_vma_policy(vma, addr, ilx);
> -	if (!pol)
> -		pol = get_task_policy(current);
> -	if (pol->mode == MPOL_INTERLEAVE) {
> -		*ilx += vma->vm_pgoff >> order;
> -		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> -	}
> -	return pol;
> +	return get_task_vma_policy(current, vma, addr, order, ilx);

I do not think that all get_vma_policy take task_lock (just random check
dequeue_hugetlb_folio_vma->huge_node->get_vma_policy AFAICS)

Also I do not see policy_nodemask to be handled anywhere. That one is
used along with get_vma_policy (sometimes hidden like in
alloc_pages_mpol). It has a dependency on
cpuset_nodemask_valid_mems_allowed. That means that e.g. mbind on a
remote task would be constrained by current task cpuset when allocating
migration targets for the target task. I am wondering how many other
dependencies like that are lurking there.
-- 
Michal Hocko
SUSE Labs

