Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315D873A190
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFVNMg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVNMf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 09:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9801FDD
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2023 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687439500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL8itRGmxApUKDOrvea4cRz5mnSUjX/8ZLxFKQlLox8=;
        b=CLGYB8PI6b4R3Ja0/X/dITVP9zfCpmEHxZYg+ZbdgX79gZVY5007ypxpd3+obrThZJlrRD
        wuctEKM8wYyPmExS8rzxvvDFH2KVAaucv5HiN9FMN+JdvwwYmEKEayqkZD8G36FkK+bJBn
        5n71BY3nNxQBeloGOZmih1Ym6iMvPwo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-B0Iykp3DNRWouDNQEewCXQ-1; Thu, 22 Jun 2023 09:11:39 -0400
X-MC-Unique: B0Iykp3DNRWouDNQEewCXQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b589ea2453so14261021fa.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2023 06:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439496; x=1690031496;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sL8itRGmxApUKDOrvea4cRz5mnSUjX/8ZLxFKQlLox8=;
        b=lAxb11cxv1gDD1PMRzGKppkpH50ghhePr3GXriZNuiNHjDd27fttD+HovhXOxfjSWo
         HxmDOjB6GQYOWk4z+n6Shp48cNlAO/PbBsfLtjxVpe6YxAurcB335LHmm6EIKaHnKKh1
         4oVSgX7iXAQo8tHH5GoP/ylEHOqCpn0yr0fswgpM1a6qyRIBGcJCnmYaArfdXfm0bJt8
         QtyuUKBPfdMZ/aVLTNIMn25N63brApDYJUP85B+nNEMMGgC+4Zt1UWVHONiLXnxI53WQ
         nD6Ly/mzyMAEi8+nFUQu/2/5WEPp76rZMSOrAUignU4M7g96bHG7cyznzBLRhZs5CrUc
         whfQ==
X-Gm-Message-State: AC+VfDyfg916nC1SoOXlvNDlnNSgKoUSGMCAkgSCqO4x38HUUoQ8B9Fk
        yrwAd1yKEKKZeNhmTSzMM3xzShLPpggVz+Gg2sGZt/q+hfgwdp0LgHHVkWjVZU24XvyfwPzwlOJ
        pBgj3Jh15qWYWLmww/EeUew==
X-Received: by 2002:a19:7710:0:b0:4f8:6800:86f6 with SMTP id s16-20020a197710000000b004f8680086f6mr7663774lfc.49.1687439496652;
        Thu, 22 Jun 2023 06:11:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XeMu+ILD2rIWpjmZgWGZlKWI9+Th3UDxS632DqbBLE4GiDliqEnF0ulmrbywCCnR/Rw0JbA==
X-Received: by 2002:a19:7710:0:b0:4f8:6800:86f6 with SMTP id s16-20020a197710000000b004f8680086f6mr7663723lfc.49.1687439496259;
        Thu, 22 Jun 2023 06:11:36 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-192.inter.net.il. [84.229.250.192])
        by smtp.gmail.com with ESMTPSA id k37-20020a05600c1ca500b003f9b3829269sm2706502wms.2.2023.06.22.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:11:35 -0700 (PDT)
Message-ID: <7a9f193e6fa9db1d5fa0eb4a91927a866909f13c.camel@redhat.com>
Subject: Re: [PATCH v2 0/2] send tlb_remove_table_smp_sync IPI only to
 necessary CPUs
From:   ypodemsk@redhat.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mtosatti@redhat.com, ppandit@redhat.com, david@redhat.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, paulmck@kernel.org,
        frederic@kernel.org, will@kernel.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 16:11:32 +0300
In-Reply-To: <20230621074337.GF2046280@hirez.programming.kicks-ass.net>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
         <20230621074337.GF2046280@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2023-06-21 at 09:43 +0200, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 05:46:16PM +0300, Yair Podemsky wrote:
> > Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> > indiscriminately, this causes unnecessary work and delays notable
> > in
> > real-time use-cases and isolated cpus.
> > By limiting the IPI to only be sent to cpus referencing the
> > effected
> > mm.
> > a config to differentiate architectures that support mm_cpumask
> > from
> > those that don't will allow safe usage of this feature.
> > 
> > changes from -v1:
> > - Previous version included a patch to only send the IPI to CPU's
> > with
> > context_tracking in the kernel space, this was removed due to race 
> > condition concerns.
> > - for archs that do not maintain mm_cpumask the mask used should be
> >  cpu_online_mask (Peter Zijlstra).
> >  
> 
> Would it not be much better to fix the root cause? As per the last
> time,
> there's patches that cure the thp abuse of this.
> 
Hi Peter,
Thanks for your reply.
There are two code paths leading to this IPI, one is the thp,
But the other is the failure to allocate page in tlb_remove_table,
It is the the second path that we are most interested in as it was
found
to cause interference in a real time process for a client (That system
did
 not have thp).
So while curing thp abuses is a good thing, it will not unfortunately
solve
our root cause.
If you have any idea of how to remove the tlb_remove_table_sync_one()
usage
in the tlb_remove_table()->tlb_remove_table_one() call path -- the
usage 
that's relevant for us -- that would be great. As long as we can't
remove
that, I'm afraid all we can do is optimize for it to not broadcast an
IPI
to all CPUs in the system, as done in this patch.
Thanks,
Yair

