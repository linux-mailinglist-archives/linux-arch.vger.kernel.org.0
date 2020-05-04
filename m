Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782B61C362E
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDJxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 4 May 2020 05:53:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728339AbgEDJxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2020 05:53:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0449Wevn154538;
        Mon, 4 May 2020 05:52:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s50fcewg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 05:52:00 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0449Y0Fw161848;
        Mon, 4 May 2020 05:51:59 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s50fcew4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 05:51:59 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0449ofx1028861;
        Mon, 4 May 2020 09:51:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 30s0g5ht3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 09:51:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0449ptPp10682730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 09:51:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B19B52050;
        Mon,  4 May 2020 09:51:55 +0000 (GMT)
Received: from localhost (unknown [9.85.127.4])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE3F75204F;
        Mon,  4 May 2020 09:51:54 +0000 (GMT)
Date:   Mon, 04 May 2020 15:21:53 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 12/14] docs: move remaining stuff under
 Documentation/*.txt to Documentation/staging
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        =?iso-8859-1?q?Greg=0A?= Kroah-Hartman 
        <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arch@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        =?iso-8859-1?q?Sameer=0A?= Rahmani <lxsameer@gnu.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        tee-dev@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <28687056965ff46c0e6c81663a419bc59cfb94b4.1588345503.git.mchehab+huawei@kernel.org>
        <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
In-Reply-To: <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1588585777.904qzycqcn.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_05:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040078
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Masami Hiramatsu wrote:
> On Fri,  1 May 2020 17:37:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
>> There are several files that I was unable to find a proper place
>> for them, and 3 ones that are still in plain old text format.
>> 
>> Let's place those stuff behind the carpet, as we'd like to keep the
>> root directory clean.
>> 
>> We can later discuss and move those into better places.
> 
> Hi Mauro,
> 
> Thanks for cleaning it up! Tentatively moving kprobes.txt under
> staging/ is good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> BTW, I think kprobes.txt is under trace/ or we may be better
> making a new core-api/events/ directory and prepare other event
> systems (PMU, uprobes, and hw_breakpoint.) 

I think it would be good to move kprobes.txt under trace/ -- all other 
tracing bits are already present there, including uprobes.


- Naveen

