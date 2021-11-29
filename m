Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D446146C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Nov 2021 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhK2MDC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Nov 2021 07:03:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbhK2MBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2021 07:01:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB431FD38;
        Mon, 29 Nov 2021 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638187063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVDQcZLHC3tPkZdXshg+mfyHdXB90Lp7oCFBvM1e3JM=;
        b=AgaHeOHi1NsfHACoVX9xaT0TLBu4DfbDjvMkx0ruxufTKt4Al869dicbkc4oyuYIWMfZAt
        Jcd2+zlemTc2ncDC3oNQzTeNv3eDbHylTIwO/BDjDyxqnHP0nouQoHHRsUW8dblF3goFwa
        Ma3rWyALvggnm3YxqsikVuB/YZtVlDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638187063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVDQcZLHC3tPkZdXshg+mfyHdXB90Lp7oCFBvM1e3JM=;
        b=wsq6sBFCJOr1290Umq666MEOHGFk3VCCUzpG0XAs3oWuvGVeb2B5L/Gy2XELaCcNbX988M
        GTN1EwBL0nBeQMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 696BD13A86;
        Mon, 29 Nov 2021 11:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 47rlFjfApGG+IgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 29 Nov 2021 11:57:43 +0000
Date:   Mon, 29 Nov 2021 12:58:53 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'David Howells' <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Message-ID: <YaTAffbvzxGGsVIv@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!
> > > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > > long long (unsigned) int to just long (unsigned) int in order to match
> > > the uint64_t and int64_t size in userspace.
> 
> That is a massive UAPI change you can't do.

Understood.

However it can still be changed if user asks for it explicitly right?

What about guarding the change with __STDINT_COMPATIBLE_TYPES__ as:

#if defined(__STDINT_COMPATIBLE_TYPES__)
# include <stdint.h>

typedef __u64 uint64_t;
...

#else
# include <asm-generic/int-ll64.h>
#endif

-- 
Cyril Hrubis
chrubis@suse.cz
