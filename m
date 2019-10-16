Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B886D8AEE
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391672AbfJPI2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 04:28:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391631AbfJPI2o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 04:28:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G8RLQ5126410
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 04:28:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnyevgprs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 04:28:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 16 Oct 2019 09:28:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 09:28:33 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G8SWqN19661040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 08:28:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7E88A4057;
        Wed, 16 Oct 2019 08:28:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C7A3A4040;
        Wed, 16 Oct 2019 08:28:32 +0000 (GMT)
Received: from osiris (unknown [9.152.212.85])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Oct 2019 08:28:32 +0000 (GMT)
Date:   Wed, 16 Oct 2019 10:28:30 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and
 NOTES
References: <20191011000609.29728-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
X-TM-AS-GCONF: 00
x-cbid: 19101608-0016-0000-0000-000002B87DFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101608-0017-0000-0000-000033199F8D
Message-Id: <20191016082830.GC4267@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=910 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160075
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 05:05:40PM -0700, Kees Cook wrote:
> Arch maintainers: please send Acks (if you haven't already) for your
> respective linker script changes; the intention is for this series to
> land via -tip.
> 
> v1: https://lore.kernel.org/lkml/20190926175602.33098-1-keescook@chromium.org
> v2: clean up commit messages, rename RO_EXCEPTION_TABLE (bp)
> 
> 
> This series works to move the linker sections for NOTES and
> EXCEPTION_TABLE into the RO_DATA area, where they belong on most
> (all?) architectures. The problem being addressed was the discovery
> by Rick Edgecombe that the exception table was accidentally marked
> executable while he was developing his execute-only-memory series. When
> permissions were flipped from readable-and-executable to only-executable,
> the exception table became unreadable, causing things to explode rather
> badly. :)

Feel free to add
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
to every patch in this series which touches s390.

