Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4697136B694
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhDZQQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 12:16:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234351AbhDZQQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:54 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QG2uBI170971;
        Mon, 26 Apr 2021 12:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=E0kz0EJfOSMbctgZHIbPrtsz8wCykbYF4ml7+FBNOuY=;
 b=WO80uvnYRYqyv+Q6od0ijlVE5L6kICg88586ylX/pdgSA6W29I8sa0/mwkHcbrlB6ywy
 YjZ4J7pJZkzzbtz9tTf1Ie+QEoMmRjAeBqdRYipvJ/N5ckl934Fn/oH5oo2jQ7lUT1DV
 /C9vXZu+0Gl7pife8m7eSi7YzXdL2cHcrTITIV8yzMPeVPXODDa6bE5n8m1ynIa+fnyi
 crmIwR969sK/WYte6NoLz1FO6w/gBXfP3UD6hMb3Y9EoyNpIguado18CQqF+rPg3eheZ
 J7BlTAOh+xKpulAAxf4Dyhq1RIPbuZverTCVzCY2jkTCBZYVpW9U2aDzJJKXmb89OM14 og== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 385xg15n5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 12:16:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QGEmO5021241;
        Mon, 26 Apr 2021 16:16:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 384gjxrf19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 16:16:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QGFwre40239400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 16:15:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B57D942042;
        Mon, 26 Apr 2021 16:15:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB22E42041;
        Mon, 26 Apr 2021 16:15:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.40.129])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Apr 2021 16:15:57 +0000 (GMT)
Date:   Mon, 26 Apr 2021 19:15:55 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Message-ID: <YIbnO3BhOeUSRU0E@linux.ibm.com>
References: <20210426101004.42695-1-isaev@synopsys.com>
 <YIakBTNpLsPJaj7i@linux.ibm.com>
 <BY5PR12MB41318EB561C2E936B0371B5EDF429@BY5PR12MB4131.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB41318EB561C2E936B0371B5EDF429@BY5PR12MB4131.namprd12.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BLF-7QuEMiNJAE9cDSBetA1gurf1Ts6J
X-Proofpoint-ORIG-GUID: BLF-7QuEMiNJAE9cDSBetA1gurf1Ts6J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_08:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=887 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260122
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 26, 2021 at 11:55:00AM +0000, Vladimir Isaev wrote:
> Hi Mike,
> 
> On Mon, April 26, 2021 2:29 PM, Mike Rapoport wrote:
> > On Mon, Apr 26, 2021 at 01:10:04PM +0300, Vladimir Isaev wrote:
> > > -	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
> > > +	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
> > 
> > This is correct with PAE40, but it will break !PAE40 when "highmem" has lower
> > addresses than lowmem.
> > 
> > It rather should be something like:
> > 
> >         if (IS_ENABLED(CONFIG_ARC_HAS_PAE40))
> >                 max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
> >         else
> >             	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
> > 
> 
> Not sure if I understand why we should have min_low_pfn here. In !PAE40
> case max_high_pfn just will be smaller than min_low_pfn.

Hmm, actually, you are right. This should be fine.

-- 
Sincerely yours,
Mike.
