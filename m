Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E44F23DF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiDEHDk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiDEHDj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 03:03:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327A11A0A;
        Tue,  5 Apr 2022 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mp3FkWfau1S2xgosNtCUIbLswXRyF5ZJmpSQNxIjOFE=; b=PceITjenUqvRPWFAG6YacvJf+N
        BsmuQX2njcZATW05zeEES/1ee8MArXUr7R6qqJwCDSTFPAT1Zk78SOOan1d9vu4cJOirnaXtA+WJX
        MKxURMhhS0wEyDQ0AuT0m8T3UsDgEX3so22MnTCf++9VWRjdNbT7Y318dAxRmpfkexBNYZLbLV1ms
        AyrG3GcQkTK/zHEf8faCUzZ5sattia6epZcg0hxU+HVLWBA6P4AOiyEX2dRta+u90l818EBP5JzhQ
        eAiPAGzhMrpvLYooUfhjaAXxSalShLj7i9+sF6Pe7nVtJbO9eCtJ/U1V8FWl4XSIbIYWJN1iPJYBL
        drGYOZfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbdC3-00HOXX-UA; Tue, 05 Apr 2022 07:01:35 +0000
Date:   Tue, 5 Apr 2022 00:01:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization list <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <YkvpT3PFcbgcMCWy@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> I think the users all have their own copies, at least the ones I could
> find on codesearch.debian.org. However, there are 27 virtio_*.h
> files in include/uapi/linux that probably should stay together for
> the purpose of defining the virtio protocol, and some others might
> be uapi relevant.
> 
> I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> in it, and includes the virtio_ring.h header indirectly.

Uhh.  We had a somilar mess (but at a smaller scale) in nvme, where
the uapi nvme.h contained both the UAPI and the protocol definition.
We took a hard break to only have a nvme_ioctl.h in the uapi header
and linux/nvme.h for the protocol.  This did break a bit of userspace
compilation (but not running obviously) at the time, but really made
the headers much easier to main.  Some userspace keeps on copying
nvme.h with the protocol definitions.
