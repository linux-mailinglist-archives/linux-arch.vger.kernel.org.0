Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9181B73E243
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFZOh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFZOh2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 10:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0D10D7
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2023 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687790199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvcSqXCnz9zVXylEiOugaJe8PBAXaMauU+4YTqF2Kks=;
        b=AhwlQ7doRHT+6bTdS6Q5Kqd5aUioBBJjk3wDC5SFJ7P92TFw2UEdohx1guF+B3bFDe1sbM
        b87hevo19/jk3McHBWGTUYKh2/cJ/G7Ng5wWTvmxb+tGsEAPUpygGgiXlHi/VrUZdnQbYg
        TAW4+4WgHxpBdlfc0oKQ93gnxdh6YJI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-HY_3-F_JPCyPCEXh4LYvOg-1; Mon, 26 Jun 2023 10:36:38 -0400
X-MC-Unique: HY_3-F_JPCyPCEXh4LYvOg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-763a397a3ceso385384485a.1
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2023 07:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790198; x=1690382198;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvcSqXCnz9zVXylEiOugaJe8PBAXaMauU+4YTqF2Kks=;
        b=RQS1Zb1P+tZ8n6KDTutDrk2RL5mDB6MLEe34r+6jqL7ZyQPuTEz1/bsS+YSizF4Yvq
         /BhbXfq9oQ15GCkAyGAE8sDIHLJtq4D7zI0zAmi4WRB2f4C5THAVA0OgZtNLMeeJF/PQ
         U0RLee1aneX8BpTpn/VR+t8qBvmFkdYS/ZxAEqg/heW8u8tt8lEmuKIoI7PqVB/QKDT9
         Fd2ByC7FOnlHM7FlHn2QziDdq/CqqPDz81taglq16AP8f11SME2xSz/sKZxXlhvWry8I
         9Nkx2NZQQFLTdSZhPYwC3p8+HchBUoCiycGcnCYAfZzAPvRDJ8NNC2yAJcBbkwNqXFjD
         iiTQ==
X-Gm-Message-State: AC+VfDystBowumznBHEH4Cg0H19DSRsZLahJnyi7WcHBw72M7hrfdAiQ
        IzIgxMsf7ubZLDAM8Yme0fZrXXfFYbVTxqLS6Qs+inT0N+HgcR6sBMxrFRxX8W/dLTw1Jfh5TjD
        w660c0TWRkKXlqHt3UiIq5g==
X-Received: by 2002:a05:620a:2b88:b0:762:5179:5d97 with SMTP id dz8-20020a05620a2b8800b0076251795d97mr26896707qkb.12.1687790197710;
        Mon, 26 Jun 2023 07:36:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79/JfP3Hny6V9tnqkHShvsxIy9E8rAkOfBtz9lcAvMdQVNdzhuBr1C3eS+Bxuk3VP5Pg8PBg==
X-Received: by 2002:a05:620a:2b88:b0:762:5179:5d97 with SMTP id dz8-20020a05620a2b8800b0076251795d97mr26896682qkb.12.1687790197466;
        Mon, 26 Jun 2023 07:36:37 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-192.inter.net.il. [84.229.250.192])
        by smtp.gmail.com with ESMTPSA id pe34-20020a05620a852200b00765a71e399bsm1204141qkn.55.2023.06.26.07.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:36:37 -0700 (PDT)
Message-ID: <cccb5351e48b11e6c657bcfa28632f49cb9cc800.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync
 IPI only to MM CPUs
From:   ypodemsk@redhat.com
To:     Dave Hansen <dave.hansen@intel.com>, mtosatti@redhat.com,
        ppandit@redhat.com, david@redhat.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, frederic@kernel.org,
        will@kernel.org, peterz@infradead.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 26 Jun 2023 17:36:28 +0300
In-Reply-To: <d0ef9148-3c95-87bb-26f9-ea0920a4faa4@intel.com>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
         <20230620144618.125703-3-ypodemsk@redhat.com>
         <680fadba-9104-3914-5175-e207fd3d9246@intel.com>
         <79f29f99fa07c46dbaee7b802cdd7b477b2d8dd1.camel@redhat.com>
         <d0ef9148-3c95-87bb-26f9-ea0920a4faa4@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-06-22 at 06:37 -0700, Dave Hansen wrote:
> On 6/22/23 06:14, ypodemsk@redhat.com wrote:
> > I will send a new version with the local variable as you suggested
> > soon.
> > As for the config name, what about CONFIG_ARCH_HAS_MM_CPUMASK?
> 
> The confusing part about that name is that mm_cpumask() and
> mm->cpu_bitmap[] are defined unconditionally.  So, they're *around*
> unconditionally but just aren't updated.
> 
I think your right about the config name,
How about the
CONFIG_ARCH_USE_MM_CPUMASK?
This has the right semantic as these archs use the cpumask field of the
mm struct.

> BTW, it would also be nice to have _some_ kind of data behind this
> patch.
> 
> Fewer IPIs are better I guess, but it would still be nice if you
> could say:
> 
> 	Before this patch, /proc/interrupts showed 123 IPIs/hour for an
> 	isolated CPU.  After the approach here, it was 0.
> 
> ... or something.

This is part of an ongoing effort to remove IPIs and this one was found
via code inspection.


