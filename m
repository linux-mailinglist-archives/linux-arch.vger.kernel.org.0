Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BD73A216
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFVNnP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjFVNmv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 09:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B9199F
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2023 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687441319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFmMS1U29te7tFKtgkPWLc+o83wVHmxe900XZpUTdy8=;
        b=VXSWyha5A0K+hGTtHOfyj1ddSw1Zuf598TweVHP/NDk2iG0t0ieK53CSIJIg/LvLY9ibQF
        O47IKH+OelrQDZb1IwMshCf1Y8uZTyruzbUT/atQlKTTgk9bL6agLprEF1mehqlfQUsWcX
        psi4R//+YBixC2ghiVm9n8SNQSK2xmw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-gHPWKO21MFaNd35SQfD9XQ-1; Thu, 22 Jun 2023 09:41:52 -0400
X-MC-Unique: gHPWKO21MFaNd35SQfD9XQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2FA8104458A;
        Thu, 22 Jun 2023 13:41:48 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FD83112132C;
        Thu, 22 Jun 2023 13:41:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7AF94400E05F5; Thu, 22 Jun 2023 09:47:22 -0300 (-03)
Date:   Thu, 22 Jun 2023 09:47:22 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, ppandit@redhat.com,
        david@redhat.com, linux@armlinux.org.uk, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, frederic@kernel.org,
        will@kernel.org, ardb@kernel.org, samitolvanen@google.com,
        juerg.haefliger@canonical.com, arnd@arndb.de,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] send tlb_remove_table_smp_sync IPI only to
 necessary CPUs
Message-ID: <ZJRC2s4sIuJ9V3A0@tpad>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
 <20230621074337.GF2046280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621074337.GF2046280@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Wed, Jun 21, 2023 at 09:43:37AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 05:46:16PM +0300, Yair Podemsky wrote:
> > Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> > indiscriminately, this causes unnecessary work and delays notable in
> > real-time use-cases and isolated cpus.
> > By limiting the IPI to only be sent to cpus referencing the effected
> > mm.
> > a config to differentiate architectures that support mm_cpumask from
> > those that don't will allow safe usage of this feature.
> > 
> > changes from -v1:
> > - Previous version included a patch to only send the IPI to CPU's with
> > context_tracking in the kernel space, this was removed due to race 
> > condition concerns.
> > - for archs that do not maintain mm_cpumask the mask used should be
> >  cpu_online_mask (Peter Zijlstra).
> >  
> 
> Would it not be much better to fix the root cause? As per the last time,
> there's patches that cure the thp abuse of this.

The other case where the IPI can happen is:

CPU-0                                   CPU-1

tlb_remove_table
tlb_remove_table_sync_one
IPI
                                        local_irq_disable
                                        gup_fast
                                        local_irq_enable


So its not only the THP case.

