Return-Path: <linux-arch+bounces-13892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61968BB5B78
	for <lists+linux-arch@lfdr.de>; Fri, 03 Oct 2025 03:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7F424E684A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88405207A22;
	Fri,  3 Oct 2025 01:13:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5A202961;
	Fri,  3 Oct 2025 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453992; cv=none; b=tfhuVwgPfAz/C6G3IiKdvQeZ7sj5vBwNFpWn+O6HNY/1zF2zr0HdZp33vjw1zZFfwfM16jeBWOxXOtMVbQWp3DwjQR4rZ9FlSTF1K1Xy8VV3lA6qmGb8lTVbtUEPCngYrn1WZ/CVpgqmCYP/WXr8szOqOf2miie80WTDnRi8OlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453992; c=relaxed/simple;
	bh=hk7Rlsd9UPPMJ2Q0igAIU2AnRfE/DegFn6VbdMtkOoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct7UXUFSMGSuTUEcHZeDQVlltqeg4R0r90aABGTKam51OCtl2lwZ0NZvuM33Rh/l9wRKsW8P59TQQkqTPBDmAVt7NJ1FSNibEozHDbH4hGMkjixjnUU29ct12IWoBrbJg1ejR37ZPQ+d5STI8NsP61Bzod/Xb/0umnb90QVOQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-0c-68df2323f589
Date: Fri, 3 Oct 2025 10:13:02 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 30/47] fs/jbd2: use a weaker annotation in journal
 handling
Message-ID: <20251003011302.GE75385@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-31-byungchul@sk.com>
 <bmthlv2tsd76mgzaoy5gspzdkved6le5xv23xjsc3yafkhrsgh@vvmjdwygm7gn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bmthlv2tsd76mgzaoy5gspzdkved6le5xv23xjsc3yafkhrsgh@vvmjdwygm7gn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/lPWfDwWkZvbVA27qA0UWLeIguEkSnD0UQfagoG3lwo23a
	VqZFYeZyFYZpJc4us4t5I9fMULtNS2Nd16Sy0HWhLJl28TIrTduMqG8//v+H3/N8eHha2cJO
	4vWmHZLZpDWosZyRd0cUz5qqea2baxvAYK0bYaDXOYyh+/V1Ft67sxEMPnpCQ8EJL4Lit+00
	XG32I/iQW0ND99NTFNS9qefgaWCIgraTeRRUuFZBQSeGk1cmwMPzbQyUZEyDokctLIw4kqG5
	4iMHgY48DK6XTQhs9f0MFJ5pw9BSfwqDv3KEBa/7AQu+Ci8DHnsZA8GjKvAey2GhpP8LBz63
	g4LSbwUsdDw7SIEzy85BzW0rguxP1zHk+xwYnuedxXBiyIbBdjdIQ03TAAfOb5cw9FWUY/ic
	28dCUZOfi58rDliPMmJ59TVKtPp+YbHyTCUS+y4eoEVrbojudH2hxZtBByPeP0fEOns7Jzpc
	O8XzNzopsbinnxVfBRaLrvJDWHT15HFrojbIFyVKBn2qZJ6zZItc96S9kk7JFtIuFFoy0OmI
	w0jGE2E++dgxgP6yr+g4FWZGmErqegJMmLEwg7S2/qDDHCmoiL25LJTLeVooU5HqF5mjxThh
	HbH25+MwKwQgV4+00+EhpVCCyGDVY/SnGEs8he9HrbQQQ1qHO0Pb+BCryKVhPhzLhNXk3I+v
	oyPjBQ1xX7tHhT1EeCcjDVW3uD+XTiQNpa1MLhLs/2nt/2nt/7QORJcjpd6UatTqDfNn69JN
	+rTZW5ONLhR6tZK9QxtrUY93bSMSeKSOUIgpfp2S1aZa0o2NiPC0OlKxpbRNp1QkatN3S+bk
	BPNOg2RpRCqeUU9QxAV3JSqFJO0OaZskpUjmvy3FyyZloPwj0VFDacZ5NQvcSyVmbdY6Tdnk
	OfUrV/C/cqIOrDHEOcdkaafEG2Mu54CmN0F+IdCSqNi8nInes8jGLJy5u2P6ehT51Zb0+GWX
	4Vjs9rHssviuKaYFDd81F321nQmBWsU+5NlQHUx+99Mz6HkYvQlJ9/b7nbKFw7LM3tgHcUlq
	xqLTxsbQZov2N8+HMXdmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHPffc3nvp7HLXMbmjiVlacYsRH/ORn84sMyZ6s2TqH1tYjGY0
	4842PNMqik8eNhBcZq0rSAtaKHYInSAPFbELwVjjEHlUBYUKmKIgIMZRFArtblkW/efkc76P
	3+/8cRgsn5NEM9qUfYIuRZ2kpKSkdPtXObEqVb9mVa53MTzMaibBP5lHQnG1k4K82iIJdFyq
	QtDvz0PwJmDFYGgMkTBnctMwOd1LQ8jlRlDQacLgrM8i4J+aIAWjN18jMA/6KCgcySJhwvEr
	AsszKw0jt7bBeH+TBELe5wR0T40hcPiCBPiacxHMFSTC+bI6CgJt7RgKzR0ISge9GIZrRLPe
	/QSBqyKbgiFjAwaP70O475+g4I75JAXjncUEvKyhwJbtkkCJ1YQgx15NQUFJLQmNA9dp6Byd
	JaCvwERAVe130O94RkKrsYwQ3yemLkeBtTCHEI9hAsx/NhEw7aik4a69jwRHZgxY2zwSeFph
	oWF2cDWEbKngrnpOg/eUmYRL4+2Sb8yIf2P4jeQr664QvKFrjuKd55yID8yYED95IQfzBqN4
	vTk2gfkTdQf4C61jFD/jf0Dxrikbyf9dxvGn22L5RouX5k/89ZjeuXGXdFOCkKRNF3Qrv46X
	atq9TpyWyx4sL9JnopKF+SiC4di1XJf1dyLMJLuEa3w9SoaZYj/nenqmcZgjWQVncV8UdSmD
	2YsKrq47e974mP2BM/jPUGGWscDVn/TicEjOOhAXqL6H/jM+4u4U+eanYnYZ1xMcEbcxIiu4
	P4JMWI5gt3Nl06/mI5+wKq75ym3CiGSW99qW99qWd20bwpUoUpuSnqzWJq1boU/UZKRoD674
	OTW5Fomf0nF09vQ1NOnZ1oJYBikXyvi0Jxq5RJ2uz0huQRyDlZGy+Io+jVyWoM44JOhSf9Lt
	TxL0LUjBkMoo2bdxQryc3aveJyQKQpqg+98lmIjoTKRYs2dg3ZYt3RVXF5d+IexuHWo2NsQ8
	+mzRTntwY6ln96nymSW3zPn+tru9U9mukqb9Q3uG7arh6PU7YvLX62/vONb76dsGO2FQJRxZ
	vnXgcHmUrTUucKZvweUfAx1pNzaHvjx7fO8vH4yUnl0wkeCZenl0A3yvlGnjugaWxt7Y2oBf
	rFSSeo169TKs06v/BVxfeWGQAwAA
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 10:40:56AM +0200, Jan Kara wrote:
> On Thu 02-10-25 17:12:30, Byungchul Park wrote:
> > jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
> > to be placed between start_this_handle() and stop_this_handle().  So it
> > marks the region with rwsem_acquire_read() and rwsem_release().
> >
> > However, the annotation is too strong for that purpose.  We don't have
> > to use more than try lock annotation for that.
> >
> > rwsem_acquire_read() implies:
> >
> >    1. might be a waiter on contention of the lock.
> >    2. enter to the critical section of the lock.
> >
> > All we need in here is to act 2, not 1.  So trylock version of
> > annotation is sufficient for that purpose.  Now that dept partially
> > relies on lockdep annotaions, dept interpets rwsem_acquire_read() as a
> > potential wait and might report a deadlock by the wait.
> >
> > Replace it with trylock version of annotation.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> Indeed. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you, Jan.

	Byungchul

>                                                                 Honza
> 
> > ---
> >  fs/jbd2/transaction.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > index c7867139af69..b4e65f51bf5e 100644
> > --- a/fs/jbd2/transaction.c
> > +++ b/fs/jbd2/transaction.c
> > @@ -441,7 +441,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
> >       read_unlock(&journal->j_state_lock);
> >       current->journal_info = handle;
> >
> > -     rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
> > +     rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
> >       jbd2_journal_free_transaction(new_transaction);
> >       /*
> >        * Ensure that no allocations done while the transaction is open are
> > --
> > 2.17.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

