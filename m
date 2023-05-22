Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48370BF74
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjEVNPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEVNPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 09:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6142ABE
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684761259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJa+GKU9edCanEPVCfWeFwI5Lsvvl9efoskVffi2Y6Y=;
        b=IXuqPBIdGVxFLRFbhGM8M9ceD9irbeQHeMxydY/eHyul4IAci6ARba4HFBQJzzcNwn+dQF
        itN3WYhrd0YviPRKj2qanK6vRSZFkxo1FQbnowslhQBMd1VixRZbBS1C/8Hf4d4tehdWhU
        0hW5cYKTT4nOZvDTT6V6woHqZ7efHZ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-DQ9PCLdCNdyTrKjd0AyNjA-1; Mon, 22 May 2023 09:14:14 -0400
X-MC-Unique: DQ9PCLdCNdyTrKjd0AyNjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB7E3C11A24;
        Mon, 22 May 2023 13:14:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53260401026;
        Mon, 22 May 2023 13:14:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D7FEB1800606; Mon, 22 May 2023 15:14:10 +0200 (CEST)
Date:   Mon, 22 May 2023 15:14:10 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        spice-devel@lists.freedesktop.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 09/44] drm: handle HAS_IOPORT dependencies
Message-ID: <vng4tcbkdieuvlmiu36drat5t3lwzufthylcgv3qzfrodphhq3@sjxcuan5q6h6>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-10-schnelle@linux.ibm.com>
 <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  Hi,

> > There is also a direct and hard coded use in cirrus.c which according to
> > the comment is only necessary during resume.  Let's just skip this as
> > for example s390 which doesn't have I/O port support also doesen't
> > support suspend/resume.
> 
> I think we should consider making cirrus depend on HAS_IOPORT. The driver is
> only for qemu's cirrus emulation, which IIRC can only be enabled for i586.

Agree.  cirrus is x86 only (both i386 / x86_64 though).  Just require
HAS_IOPORT and be done with it.

> And it has all been deprecated long ago.

The fact that cirrus used to be the qemu default for many years is
pretty much the only reason it is still somewhat relevant today ...

take care,
  Gerd

