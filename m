Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DDFAA7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2019 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfD3NlA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Apr 2019 09:41:00 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:55078 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbfD3NlA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Apr 2019 09:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1556631659;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=beBu285rmqBNDiQNDcTz2JoVAX9N/IQQNqAAuEjGf9w=;
        b=QEyLbGOEOCUS+pzuVbWu7CfTSXtyfCXiSu09ABe7LGl3MQTXMcdv5F6CYG7Mn9m9
        Cr2tVt+C3bCs9O4bKVDgiFAK0s7ET2m4BRnOyzLL0HT/l29zNxm4UfubaGLY/kPzA8v
        J2Qz0gIalm+NimzzeXwHdPJ+XRPsb0atevd5DX+M=
Date:   Tue, 30 Apr 2019 13:40:59 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Christoph Hellwig <hch@infradead.org>
cc:     "Luck, Tony" <tony.luck@intel.com>, Meelis Roos <mroos@linux.ee>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: DISCONTIGMEM is deprecated
In-Reply-To: <20190429200957.GB27158@infradead.org>
Message-ID: <0100016a6e7a22d8-dcd24705-508f-4acc-8883-e5d61f4c0fa4-000000@email.amazonses.com>
References: <20190419094335.GJ18914@techsingularity.net> <20190419140521.GI7751@bombadil.infradead.org> <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com> <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee> <20190428081353.GB30901@infradead.org>
 <3908561D78D1C84285E8C5FCA982C28F7E9140BA@ORSMSX104.amr.corp.intel.com> <20190429200957.GB27158@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.30-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Apr 2019, Christoph Hellwig wrote:

> So maybe it it time to mark SN2 broken and see if anyone screams?
>
> Without SN2 the whole machvec mess could basically go away - the
> only real difference between the remaining machvecs is which iommu
> if any we set up.

SPARSEMEM with VMEMMAP was developed to address these
issues and allow one mapping scheme across the different platforms.

You do not need DISCONTIGMEM support for SN2. And as far as I know (from a
decade ago ok....) the distributions were using VMEMMAP instead.


