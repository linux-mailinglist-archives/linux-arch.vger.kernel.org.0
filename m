Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F374F427F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiDENZQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386623AbiDEMy6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 08:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13884344E5
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649159946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=caJ3Mn8x8sphClTxTGmFig0egR97QkRAGfFS5UfDfJg=;
        b=eagZh2GvOYDz6DSfB9tKu9oAI2g6mAI2TJEZ/CnV3yZeI0POknT4LLuLTyfsoDnrbimqUa
        nKEOy+0szij0qPzAyecrHtxPJYxtVXP2E01TEpBXgXAKdB0+JudNz6DUBwAYHulAyDiFCe
        axK1lpFQ4+ujEfNpLCyLYY2Y8SSR2Kg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-QIGZ6dTSMS-C88oofc-ZAA-1; Tue, 05 Apr 2022 07:59:05 -0400
X-MC-Unique: QIGZ6dTSMS-C88oofc-ZAA-1
Received: by mail-wr1-f71.google.com with SMTP id d29-20020adfa35d000000b002060fd92b14so1281931wrb.23
        for <linux-arch@vger.kernel.org>; Tue, 05 Apr 2022 04:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=caJ3Mn8x8sphClTxTGmFig0egR97QkRAGfFS5UfDfJg=;
        b=iwloJoomL3r2g5s+RJN1JMTJog9K4rjuVWKrCN+RXJf2l6mf7Nc9K51ZQICZoBHsRV
         sEhGd/l36VOECzEGmzLGhCGqAFKXbLpFydVTltgb/baA3csa0vb3nFIKFT6g3cowtPBl
         +m/LUe2a/6eVuz1kZ+0ji06SPwOMeStoBjsEhSz/F/c7tja8S+hg5vRG96X8hF4tdnkU
         bOBktr1UYhWrYgnLy2jeLgGot0xfItog9wX/ahPGD5SNEInE5LijG7hVHRg1xI7H09i3
         4yENMcOjXzrcO/5rX/wjxsaEqaQC6qbZ53gGIA/7uBdNKW2HDZCl0dsszFoqJBPtJtNY
         5n1w==
X-Gm-Message-State: AOAM532UlByAtNZZJUu4H0FLFJLaZC1goNRLI7SjpME5cAJbCxCwYgCA
        r9GsXl7MxXiyTO8mCXmYnCtHKg2NvUJmFf/PDBVCgwnBV4n8/CcRCVOEjQ0ydnGzXkecL/j18hw
        00DhXUr1suxrSqm9z5gao8Q==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr2850176wmh.21.1649159944332;
        Tue, 05 Apr 2022 04:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgAb5I4ZF3qI+9Z9tb/LO2zK3svds/SwszckCB8AT7KGF6vHKrXQi2sIZ1Gsir9F/APs8Zzw==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr2850160wmh.21.1649159944150;
        Tue, 05 Apr 2022 04:59:04 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm1949693wmc.25.2022.04.05.04.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:59:03 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:59:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405075756-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykqh3mEy5uY8spe8@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 04, 2022 at 12:44:30AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 03:19:48PM +0900, Masahiro Yamada wrote:
> >  	vr->num = num;
> >  	vr->desc = p;
> >  	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> > -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> > +	vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >  		+ align-1) & ~(align - 1));
> 
> This really does not look like it should be in a uapi header to start
> with.

It's a way to document a complex structure layout of virtio 0.9. It's
ugly but it's been like this for years. For virtio 1.0 we moved away
from this but a bunch of tools keep using legacy.

-- 
MST

