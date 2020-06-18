Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720F81FEE75
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jun 2020 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgFRJS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jun 2020 05:18:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60154 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728343AbgFRJSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Jun 2020 05:18:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I91mwZ096451;
        Thu, 18 Jun 2020 05:18:09 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31r589gj0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 05:18:09 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I99upg003755;
        Thu, 18 Jun 2020 09:18:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 31r18v04vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 09:18:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05I9I4LN61735124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 09:18:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3360EAE053;
        Thu, 18 Jun 2020 09:18:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B08AE04D;
        Thu, 18 Jun 2020 09:18:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.36])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jun 2020 09:18:01 +0000 (GMT)
Date:   Thu, 18 Jun 2020 12:17:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>, peterz@infradead.org,
        jroedel@suse.de, Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Message-ID: <20200618091759.GH6493@linux.ibm.com>
References: <20200609120533.25867-1-joro@8bytes.org>
 <20200617181226.ab213ea1531b5dd6eca1b0b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617181226.ab213ea1531b5dd6eca1b0b6@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_04:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 cotscore=-2147483648 mlxscore=0 clxscore=1015
 suspectscore=1 mlxlogscore=666 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180065
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 17, 2020 at 06:12:26PM -0700, Andrew Morton wrote:
> On Tue,  9 Jun 2020 14:05:33 +0200 Joerg Roedel <joro@8bytes.org> wrote:
> 
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > The functions are only used in two source files, so there is no need
> > for them to be in the global <linux/mm.h> header. Move them to the new
> > <linux/pgalloc-track.h> header and include it only where needed.
> > 
> > ...
> >
> > new file mode 100644
> > index 000000000000..1dcc865029a2
> > --- /dev/null
> > +++ b/include/linux/pgalloc-track.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_PGALLLC_TRACK_H
> > +#define _LINUX_PGALLLC_TRACK_H
> 
> hm, no #includes.  I guess this is OK, given the limited use.
> 
> But it does make one wonder whether ioremap.c should be moved from lib/
> to mm/ and this file should be moved from include/linux/ to mm/.

It makes sense, but I am anyway planning consolidation of pgalloc.h, so
most probably pgalloc-track will not survive until 5.9-rc1 :)

If you think that it worth moving ioremap.c to mm/ regardless of chrun,
I can send a patch for that.

> Oh well.

-- 
Sincerely yours,
Mike.
