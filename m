Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632E57B155C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 09:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjI1HvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjI1HvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 03:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10D8F
        for <linux-arch@vger.kernel.org>; Thu, 28 Sep 2023 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695887412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDF7CH8bTKhRjSz3An4kXrtZKcHrytXsVm7QLB4Bnu4=;
        b=KbZ+TWVwx8q2nm935U0EbJZiMFc/ez1zcqIVs2eT9PtUgKq24aw/adjHcTrXI4WNdj0dAf
        dHIlJwscjO/wcCBB5LxwMLZhPPk6KxwAPDMsvDmtHkH2q7aZgrb/bqhB5B19FttauZPaBu
        920xQ2mNLyyx7dfOeR1aa6V4Is0cLag=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-GL0GjoedOkilqIBhd60-qQ-1; Thu, 28 Sep 2023 03:50:08 -0400
X-MC-Unique: GL0GjoedOkilqIBhd60-qQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E3953C40C06;
        Thu, 28 Sep 2023 07:50:08 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B67B32156702;
        Thu, 28 Sep 2023 07:50:07 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id A104730C1C0A; Thu, 28 Sep 2023 07:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 981B63FD4B;
        Thu, 28 Sep 2023 09:50:07 +0200 (CEST)
Date:   Thu, 28 Sep 2023 09:50:07 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, quic_jhugo@quicinc.com,
        snitzer@kernel.org, dm <dm-devel@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix confusion around MAX_ORDER
In-Reply-To: <3c25ec6f-cd33-9445-a76f-6ec2c30755f5@redhat.com>
Message-ID: <86e7f97a-ac6b-873d-93b2-1121a464989a@redhat.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com> <3c25ec6f-cd33-9445-a76f-6ec2c30755f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Wed, 27 Sep 2023, Paolo Bonzini wrote:

> On 3/15/23 12:31, Kirill A. Shutemov wrote:
> > MAX_ORDER currently defined as number of orders page allocator supports:
> > user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> > 
> > This definition is counter-intuitive and lead to number of bugs all over
> > the kernel.
> > 
> > Fix the bugs and then change the definition of MAX_ORDER to be
> > inclusive: the range of orders user can ask from buddy allocator is
> > 0..MAX_ORDER now.

I think that exclusive MAX_ORDER is more intuitive in the C language - 
i.e. if you write "for (i = 0; i < MAX_ORDER; i++)", you are supposed to 
loop over all allowed values. If you declare an array "void 
*array[MAX_ORDER];" you are supposed to hold a value for each allowed 
order.

Pascal has for loops and array dimensions with inclusive ranges - and it 
is more prone to off-by-one errors.

Mikulas

