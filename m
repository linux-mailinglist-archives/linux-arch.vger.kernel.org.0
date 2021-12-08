Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB446D706
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 16:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhLHPgD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 10:36:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhLHPgD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 10:36:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBB8E1FD2A;
        Wed,  8 Dec 2021 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638977549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6VNz+rbMG4FKJ01MyWRZjmX8ICbIRHGfA3fPOOQX6vk=;
        b=lQmxOHPqIImGvYgUFoj/iKM+12qOie5JvMtoB4akJ2qZmCHmYbpTXL1pvnWqKwkORVb1aC
        iybWxH9xZOdHCV+A18n0UDr++hxRn356Fzb1GqFlIPDcphqBBuHc+IbeowMYndmGnjy+zO
        VXh4Y/0OKAdpEJBC2Q0SYA38L3Jw06s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638977549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6VNz+rbMG4FKJ01MyWRZjmX8ICbIRHGfA3fPOOQX6vk=;
        b=WT1UpZk6WMHwKNVbBEX+hLKKuM7l5DRaCdSSlLONT9RxyDh2ke5UNv4X9z6Hk6yl5we44/
        fPRHxkB4QtYWO5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6619913F90;
        Wed,  8 Dec 2021 15:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id quQdFw3QsGE3VAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 08 Dec 2021 15:32:29 +0000
Date:   Wed, 8 Dec 2021 16:33:47 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Zack Weinberg <zack@owlfolio.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Message-ID: <YbDQW6uakG3XD8jV@yuki>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki>
 <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
 <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
 <913509.1638457313@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913509.1638457313@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!
> > I could be persuaded otherwise with an example of a program for which
> > changing __s64 from 'long long' to 'long' would break *binary* backward
> > compatibility, or similarly for __u64.
> 
> C++ could break.

Thinking of this again we can detect C++ as well so it can be safely
enabled just for C with:

#if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
# include <asm-generic/int-l64.h>
#else
# include <asm-generic/int-ll64.h>
#endif

-- 
Cyril Hrubis
chrubis@suse.cz
