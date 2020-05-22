Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC41DF015
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgEVTjE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 15:39:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730894AbgEVTjD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 15:39:03 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04MJONWO016299;
        Fri, 22 May 2020 12:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=D02iZIBUkKDU1TsV9Iw0bmpjpLLCF9y7GIxHJ2IokEQ=;
 b=KX0ymjR2sSoAvEkKkDLaEdyeMUdKGhhbZZP/ESAvyxiYrJQp0CJYBpmuSJ5sUb8iRCjH
 q2SzCca09MslpH9IqD4ZB5j6TN2x9g4QnOeInTHvg6W5+wspxKP9CdvF38fmtnjAI5iD
 hGTkm4+vIF7TU8kuKE+MSDlFEH33r4OUSf4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 314e9tyet0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 May 2020 12:38:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 May 2020 12:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk6lbS4fDGXzF6T7XsqgnYrcpJQvEhXVAiJtbOqbhXkrCjnTsBCDp3E/QKYluo9hc50Mo7SLKwPjqUMvMQBaoCC1VI5p0oyGvnUdYy36boQxNsqRgMPqVMGp2k+N4TpV5kytBOeqdcZ2YaQs/RS8yDyphpPV9MMutjhu4FvN4UmjfktJdeF4m7y+8N+E9RfqNdejwHQlfmzNQeVG9aDTTs1gQcPtPmmKNnW/n8yziVVNXQ+K1n1G3qAMlR0RCfHcZZq8qqFLUMySJnqR0j70SeMezBlBxZ/SAd4WGm0lMQYrQ3GnPpkQar1WkWs0rvUPAniyliw6+TauhxtFR3M2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D02iZIBUkKDU1TsV9Iw0bmpjpLLCF9y7GIxHJ2IokEQ=;
 b=GddzWxkvCCqQB6ossVv868Kr+0LOf1EQlpB7JuQlrbp0gLGka51FWh3h73wWQsFRGv7ZO9RjpNxvcfmSdPT016TgMhkk4EkgP2lnyT4O7xLuVnuDmtK5BJ6ZoB/loNiQM5A//vlYgVYbUEB+e8fQQl2RDw9zT8lc1OHZ7lpSEVdh1nBhV8CpFyQVM+gLIaBFY2weZE7S+lKYCeLUgd4tHF33tXHjj0dZBxSSzxeLQAphvPCTRgdiVDqvdtoB6w69bZltsXNfjRKwWf944T5G85nXp3ae7eU6+I6DHV5HAz5X4kAQJsfeKM+NMwWroOcBQgxXaXvxiJzSPEtTOfiOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D02iZIBUkKDU1TsV9Iw0bmpjpLLCF9y7GIxHJ2IokEQ=;
 b=cEMOTmo99bATch4Si+IFLDhczK4eT6azhfrzHt66lVTY3gdHhxNjBBuGI5BGpd11oKFHwMPUssEHMl9TeyoY8YgyL8YmlF0LMl+WYr6Kmt1A0dBvkrVgmAnhtMYIUAfXV2tGIST2wft6uCOxtF1VY50kw026Gwl7iV7FBRqeavA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from MW3PR15MB3753.namprd15.prod.outlook.com (2603:10b6:303:50::17)
 by MW3PR15MB3836.namprd15.prod.outlook.com (2603:10b6:303:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Fri, 22 May
 2020 19:38:25 +0000
Received: from MW3PR15MB3753.namprd15.prod.outlook.com
 ([fe80::599e:12d9:5804:c0e7]) by MW3PR15MB3753.namprd15.prod.outlook.com
 ([fe80::599e:12d9:5804:c0e7%8]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 19:38:25 +0000
Subject: Re: Some -serious- BPF-related litmus tests
To:     <paulmck@kernel.org>, Alan Stern <stern@rowland.harvard.edu>
CC:     Peter Zijlstra <peterz@infradead.org>, <parri.andrea@gmail.com>,
        <will@kernel.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <akiyks@gmail.com>, <dlustig@nvidia.com>,
        <joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
Date:   Fri, 22 May 2020 12:38:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <20200522174352.GJ2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::36) To MW3PR15MB3753.namprd15.prod.outlook.com
 (2603:10b6:303:50::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:51:fde8:f2bb:1332] (2620:10d:c090:400::5:695) by BY5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:a03:1a0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 19:38:23 +0000
X-Originating-IP: [2620:10d:c090:400::5:695]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b954e1af-2c0e-4611-f3ba-08d7fe87b177
X-MS-TrafficTypeDiagnostic: MW3PR15MB3836:
X-Microsoft-Antispam-PRVS: <MW3PR15MB3836D26CD2F86B940500EE7BC6B40@MW3PR15MB3836.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWCIvx9b37hVYlBiu/pEi9zsZKErIV6eNNquKae3avBdshn6+1ZTcCFh1UciFsCdH9GSAGG2ekDlDya+/G2CzmBzPUdsxwUDNAlw2mLEfjDahKyhJaKvajtjx7vz+mv6sTyws9ZgHM1egiE/nb9NbThUZqwvd5LcGZv5HSlNW3lDAwyro0Z7OZuBQ3YEEpkMM1AlHmFSf84MK0HE71so3opw5aQccrtSS3HJiTF8CahcafC2aCVjE2z7NPt4bkXAf5n6AC9+Ik87Z3wsynWIxovOwhJhbHe1DZgWxZUDuHA+M4bPZqYBBO/UkpXJO/gjs9cZkGfPWsQtJvwvWIPdlU5w8oHEWszbUhukOo4uknXmMDnUEAIflPM3ZJ8sjMeQKI0AJUp3jlRZUXEnyhLpITY3WZK5yxvtlRJGgDY1lyKeeM3y1Ui751+INJ1+UOAdcZyHuILwLOLuIdl9f+rfPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3753.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(52116002)(31686004)(6486002)(66946007)(186003)(478600001)(8936002)(8676002)(2906002)(66556008)(66476007)(16526019)(966005)(7416002)(5660300002)(316002)(53546011)(31696002)(54906003)(36756003)(4326008)(2616005)(86362001)(6916009)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RqLdJyOBgC+ZJQpFiZ0Fj3Ncn7TLdj0VzAwRSv0XXaldsuI5vUrjgPbEk6ph35aMi25SngGLrTisA878ERQvUiNrtuID6kvhl6WAfx4cq2d+9nDv1Vt12wmLfMApm4sgkHrOrUeW9230pPLX1N802P77Bcw8sQRa4kDSs75lDiySyZjifXd+XD5rPANpKB++ejrRRh4zXMyHrKggDlKawqp0D2g/O0sStEnNNyrmGxJ7zH/s25Dv8edR7epOQ2SzRtvKl3VSHIcVt8JZn4KBA4PBq9PjzoEBzJ1Eo7vaLqgP4HHXlC6oG9A+AwT0ExUqg9kEuaFPqn69ybcH4JMyyM88FjpSteOTTBNgLXbtlK6+DUIsoGGqT6ZE1WsWAr3JIj3ttwlg8KHeuRfPxefrMysfcGMb0jIokTqtfvSQWBBD/5GTBkyjphDm2nhFTMLoreCmioBCzH2AH++o2M/8bcHT49ttIWxaNzx3FqNEK05uem2NRdyTWwHK/jE+sjOzUqLpSfFV6G1bNSfhWwPtzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b954e1af-2c0e-4611-f3ba-08d7fe87b177
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 19:38:25.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHBPNRvNAl/7u6VZpr+mNPVFJ2V5+uB7sTrnl3Gx7OtGEsd7Xp3+xOJTlZ5QHG0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3836
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_08:2020-05-22,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 priorityscore=1501
 cotscore=-2147483648 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220153
X-FB-Internal: deliver
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
>> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
>>> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
>>>> Hello!
>>>>
>>>> Just wanted to call your attention to some pretty cool and pretty serious
>>>> litmus tests that Andrii did as part of his BPF ring-buffer work:
>>>>
>>>> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
>>>>
>>>> Thoughts?
>>>
>>> I find:
>>>
>>> 	smp_wmb()
>>> 	smp_store_release()
>>>
>>> a _very_ weird construct. What is that supposed to even do?
>>
>> Indeed, it looks like one or the other of those is redundant (depending
>> on the context).
> 
> Probably.  Peter instead asked what it was supposed to even do.  ;-)

I agree, I think smp_wmb() is redundant here. Can't remember why I 
thought that it's necessary, this algorithm went through a bunch of 
iterations, starting as completely lockless, also using 
READ_ONCE/WRITE_ONCE at some point, and settling on 
smp_read_acquire/smp_store_release, eventually. Maybe there was some 
reason, but might be that I was just over-cautious. See reply on patch 
thread as well ([0]).

   [0] 
https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/


> 
>> Also, what use is a spinlock that is accessed in only one thread?
> 
> Multiple writers synchronize via the spinlock in this case.  I am
> guessing that his larger 16-hour test contended this spinlock.

Yes, spinlock is for coordinating multiple producers. 2p1c cases 
(bounded and unbounded) rely on this already. 1p1c cases are sort of 
subsets (but very fast to verify) checking only consumer/producer 
interaction.

> 
>> Finally, I doubt that these tests belong under tools/memory-model.
>> Shouldn't they go under the new Documentation/ directory for litmus
>> tests?  And shouldn't the patch update a README file?
> 
> Agreed, and I responded to that effect to his original patch:
> 
> https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72/

Yep, makes sense, I'll will move.

> 
> 							Thanx, Paul
> 

