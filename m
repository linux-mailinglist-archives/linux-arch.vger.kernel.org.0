Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171C6603715
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJSA0A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 20:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJSAZ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 20:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF3B978B
        for <linux-arch@vger.kernel.org>; Tue, 18 Oct 2022 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666139155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeOa45B93JvYwgR1hDKpdl7iPLUwP3auE5S9Nrg+8/s=;
        b=BBYbfw23P8aA4ZGb6/ntFEPdgpHO/R8eJU/ihxvAnUVHUpDTH2uqoYDQ07adX+Ox/+9RmU
        m2ajYI/4vcHcxLMtWxqL9TzVj7CSxrCiKHXzqVirgfwpWrxBDOk+gdOvWmejwo6wzvpsdz
        XnDdK2CYo7JJ1SiooaMOquFcq/D9qFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-OqOberSEOZ2v8-pjdQdPsw-1; Tue, 18 Oct 2022 20:25:50 -0400
X-MC-Unique: OqOberSEOZ2v8-pjdQdPsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6830980280D;
        Wed, 19 Oct 2022 00:25:49 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE99C84426;
        Wed, 19 Oct 2022 00:25:47 +0000 (UTC)
Date:   Wed, 19 Oct 2022 08:25:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [RFC PATCH 0/8] mm: ioremap: Convert architectures to take
 GENERIC_IOREMAP way (Alternative)
Message-ID: <Y09EBgoqPGy2A5WL@MiWiFi-R3L-srv>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <Y0yj0IDBVOFwCFuv@MiWiFi-R3L-srv>
 <fd7aa861-a85a-cc6d-df62-6e5e9a1b3149@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd7aa861-a85a-cc6d-df62-6e5e9a1b3149@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/17/22 at 05:06pm, Christophe Leroy wrote:
> Hi Baoquan,
> 
> Le 17/10/2022 à 02:37, Baoquan He a écrit :
> > Hi Christophe,
> > 
> > On 10/12/22 at 12:09pm, Christophe Leroy wrote:
> >> From:
> >>
> >> As proposed in the discussion related to your series, here comes an
> >> exemple of how it could be.
> >>
> >> I have taken it into ARC and IA64 architectures as an exemple. This is
> >> untested, even not compiled, it is just to illustrated my meaning in the
> >> discussion.
> >>
> >> I also added a patch for powerpc architecture, that one in tested with
> >> both pmac32_defconfig and ppc64_le_defconfig.
> >>
> >>  From my point of view, this different approach provide less churn and
> >> less intellectual disturbance than the way you do it.
> > 
> > Yes, I agree, and admire your insistence on the thing you think right or
> > better. Learn from you.
> > 
> > When you suggested this in my v2 post, I made a draft patch at below link
> > according to your suggestion to request people to review. What worried
> > me is that I am not sure it's ignored or disliked after one week of
> > waiting.
> > 
> > https://lore.kernel.org/all/YwtND%2FL8xD+ViN3r@MiWiFi-R3L-srv/#related
> > 
> > Up to now, seems people don't oppose this generic_ioremap_prot() way, we
> > can take it. So what's your plan? You want me to continue with your
> > patches wrapped in, or I can leave it to you if you want to take over?
> 
> I don't plan to steal your work. If you feel confortable with my 
> proposal, feel free to continue with it and amplify it. You have done 
> most of the job, you have a clear view of all subtilities in the 
> different architectures, so please continue, I don't plan to take over 
> the good work you've done until now.
> 
> The only purpose of my series was to illustrate my comments and convince 
> myself it was a possible way, nothing more.

Thanks a lot for all these you have done, I will post another version with
the introducing generic_ioremap_prot() way you suggesed.

