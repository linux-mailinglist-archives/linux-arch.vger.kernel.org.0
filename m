Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4000E688E62
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 05:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBCEEV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 23:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBCEET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 23:04:19 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2E3C36;
        Thu,  2 Feb 2023 20:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAbTIuzGilB9U8xQcar4uxg8G83GXBduODKFzObJyd8sxOJKOcEml8afYcJ+EFxbb8m+N4M6PqQ4qDvpiFULRr5n3Z0+pMhy4122l3LZVt5d5IEZTz2ptX3csLPil944GHJdyGElTBH7n33affaMlWI0SkwD/HoYPY/+gceWmUk2k9FbF84RTO7aGVYvN4dOVQ36x8GNI9sso1UOe7ymRzdDYOPf+NTdd1rO+KGyfMEqj1m2HrFowGgYokLB5UP+rX6ABEqiUVKwpNrzvINJUJ5YqhHHF2UQY32uZTh+K/Jj8j9LiNEcGE9iwpK9ruxQtWxGJtTCIqkX6Fl1h4tBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2PspsjFCJvf94UfJ9m/6aWx0MVTX9+LWQv7Ba8v17A=;
 b=QwYJ07RjCgyP2ik0aOQCyFgb4HboI78hU+BEZxVRTbugEoYywj8oRcNJgQ1EwBWZudkwtA5eTKv1Q4ss4hJUoyW4mQ11d0Ibr0FNtTcQVBZz4mSCrQW/JIQRzBkkWZhEd4J9eiexOyICCE6+JO9Skj7fwW0yt74tTaY9vLzPOq5G8qbpC+0CEgx0nFCIlGuJQnhhLDzXGqQ6CioBM7ptuAZMi2cw8BoPJP4I57DOSQfIhMsHbc1iwk+kc8SR6xf80V1oHoZqS7GckcIeS2kYu4x3ik3CGjOKE1cvNdgEKQVk46ogSv7tQdzl574Dnj/nxCr6Uyf3ad16jSXc1fIviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2PspsjFCJvf94UfJ9m/6aWx0MVTX9+LWQv7Ba8v17A=;
 b=QnRuK7NKjoPUT/4IhwoTsto5n4O3cPlOLVolGKRrVHaKzz8Ptl13gl/mA4DNyvK/KKLGg8kstzLwwFDGpVaJ7bJcMc151RfNasNLS9gg0C+8dWu6Lr+zgZwgRQIKXka2sHbg22hDuIuvablF3OWw7WgF5V7ukoetUn2TjpEXNRo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3582.namprd21.prod.outlook.com (2603:10b6:208:3d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.9; Fri, 3 Feb
 2023 04:04:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%7]) with mapi id 15.20.6086.009; Fri, 3 Feb 2023
 04:04:08 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>,
        Tianyu Lan <ltykernel@gmail.com>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
Thread-Topic: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
Thread-Index: AQHZLgu3KlW78QkAmUeWM8kPcyNWma68WFIAgABSlhA=
Date:   Fri, 3 Feb 2023 04:04:08 +0000
Message-ID: <BYAPR21MB168841530BB5B793D7695991D7D79@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230203010056.000021af@gmail.com>
In-Reply-To: <20230203010056.000021af@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cbc594e9-e0cf-4d0e-b973-b64e2df41ce7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-03T03:56:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3582:EE_
x-ms-office365-filtering-correlation-id: 614b7674-8245-4b62-d152-08db059bb334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75enaXM+is3OD0w78bysF+jNziVQsvavzYC6ZbpYjclTBc4lV4M7c62CMJUbpz6H6mfFG/9RoXtut544j7dPtWymqmoBZW3043BmZMlH9xY1coxLRCfg7Xjhx8VAl4cWuqtt8dATRkuQMqaYR2itREkVe5cO2wAvH+AuPeJSlEgJF5gVa7lseu736z6egDJ2f2Gnz+1KPSpWowwMtqa7beBfOcTdC0kUUJE7Z+1Ozua0Ol1pNRIk9SOB+yM5zu1ooT9b99N6iaaIBij0PMXTorhfaqAMcHXtgrWTkJM4Uc692m8PHK/+EZliMo2LjIeyIQ6P5TamoWKgOIlLaoFCzptsyc7ZqgV03s7nMfap95bQ1N1AxDnFA7wM5LZG04ANUkqJ8KV1WlxqJTzRwhkjNk9NhCJYrCNqvvvEeyTzScVOKhQPN3YS8J66irWSMcwBJS6zBFWC/7AwyYgSDLAAJGa+QJpj9HCIHuUGAyj6ZZWuGzVRCO2vZht+qhuJf6q2FeSW75PTz2arw3VphsfDxSKCld1pfzVQAMNbjs2a4EQ2wVIO0NSBws7RguYd52F17vAnatOUQGjCEmNoENmPMbUVCHRy916zX61nG9XCk4dqYObo4hmVtqx5GER5M8lVrv2VY3HwWnjNNXbo/uaDH84YgYqUiZa9ZlA1xyDNQh30Y0pmB8378EbrqwAzSm5kOcbh2BmxSq+N5YxqXhj2Ey09AueC0gwhmu2vrvok7mr0o34Kg0H8dKaWYzHGhkD5QsjhB2O7JvWHxmLykaaCinsXLI1Uog2mt05PHCquyPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(316002)(71200400001)(10290500003)(7696005)(8990500004)(110136005)(54906003)(66476007)(76116006)(66946007)(55016003)(4326008)(66556008)(66446008)(64756008)(8676002)(122000001)(82960400001)(82950400001)(38070700005)(33656002)(86362001)(38100700002)(41300700001)(186003)(9686003)(478600001)(26005)(7416002)(7406005)(52536014)(5660300002)(83380400001)(2906002)(8936002)(966005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnV8xpXnnQSkMjkzz/rw8K2cCy58D5zKkqaj1myVSX3APdkoKgK6sP3/byeq?=
 =?us-ascii?Q?xQNYpo82vcTZrfbBc6ws4REROIsj+UKMyewOTPaDitMTfsqVSOCBJnCmBIwn?=
 =?us-ascii?Q?gqVYUoQnktgk+nzaYkSl2Cr/IqqgOzs93S1IOxHpNrAJ1lj0MsjQot+QY84N?=
 =?us-ascii?Q?RZwaz9Kxse5sc5t9iTuzTBt80GzVDHnPjTGDdOEFdtvgLnogPFy+2Smgc+pP?=
 =?us-ascii?Q?mYnO/oOVmlCzUdtm21hrDQ+XWgOMxX2lEaLUQzpo/W8eHtGOsHnnZluxGJLD?=
 =?us-ascii?Q?o3mzpgEig6uD8gdW9qZufoXFNyY8fPIjS6L37+3HmQOIGZFW4kQB3JdSsJZH?=
 =?us-ascii?Q?hYbS3PEOM5K+qR5Xi5okHHyNvAo8418ycLUE41x7nxXv03kyW8vsNPmesszV?=
 =?us-ascii?Q?AcuX/ccQj8E6DzZneMP3j9ZlZngqz/pcoK6W31XzCn3GqstpnXpKNyxalUTB?=
 =?us-ascii?Q?w1d3rGe762/pIPmriiRchmHHUCyDL9giuwsSrZ2RV2bVaDZn3N3rabRhGG7o?=
 =?us-ascii?Q?PXkTj3uMRH2uGy74+t0hr1XfOappH+i827nTGNUgK3xHQwOdMAC7D4+YO7Wq?=
 =?us-ascii?Q?H8/fsJBRFkphdiT1QIwHKpSn5nBG+/4EK/S6+y6COyF5PPFkerViMs45IkYZ?=
 =?us-ascii?Q?JTN+VCn+e/c8GVT8EysSgnJ/6kmFDDcx3jdQo/lJUr4KJUGEvykUT0sHOa1X?=
 =?us-ascii?Q?HBjBt0JRH78Qh1IUoRffIXITyDVkyneW0lnTlXaLSi7gS4j312nCKeXoyxBo?=
 =?us-ascii?Q?jPby5yJORlJ4AB/LjGq69VNz4H8dC3F0T4Gm9QGdkFKvYNSgkzWruuoMc8pi?=
 =?us-ascii?Q?N+E0s4NB8+H1BIEAEpifNBxjbi4yG6TuDeBl4mpfD9hZM6E8IDM4yATknL1t?=
 =?us-ascii?Q?Di0i+QSDlutWL+xcPH/9QSOyYcwB7rFa2ljfnBQ4vW6g0gCDDKweNd+PeuuV?=
 =?us-ascii?Q?eb+UAqUYEPwCf4FePNL51h9s/tD1uPbRkb1/D5SoMxyST90s4rVf+77l9ptq?=
 =?us-ascii?Q?LABI41YF87/ADq9mfYn9KUIp5M4zd4VTMbJUCxNQKp9ZwuQv4CBlaA9Yh0sN?=
 =?us-ascii?Q?DXhvzWTWqb2eWEQHs9M5XTJugBeGC3MHHtH5/Ph1M1wBhfjnWbPVBj5T78QH?=
 =?us-ascii?Q?Om4Kxz2WXy1HkEE8e/BaRIqCSgbGWe/sKG6PYQATpVlD5tp/5MDPnspsMmvH?=
 =?us-ascii?Q?Yhl5bZ1clMEJnG+aZctOhYjjNYCRQM0nE7qOU2dk/KXxYagWxVZprBnIb+G8?=
 =?us-ascii?Q?24a68gZI5WNWeeO6Qrh1rwLun0xiBnvwzi3wu++6mXqW4F+AM93zBfDimlQt?=
 =?us-ascii?Q?05+nKQZy3OI6M5BcZGSiw/nPCYW8QMvQ///zy+ln8+qssTVHLU1TF9PN3lTB?=
 =?us-ascii?Q?P9qG6TT65K3ToQZBFh2bhe+r/NEBBljhzRBJrZD0k45+Xw7ykmmNBxw59NUX?=
 =?us-ascii?Q?b60xW/SDEsoTpRksIiHxaYD5POaUIz4NQ7EhxODaxZ/C/u+44YmmDd8O1f7L?=
 =?us-ascii?Q?L4f7cA9J75EEvkX4ueXBg5t8a3XVmka1ZILX3ttUpcZvp74Tc6pm0UPigyeD?=
 =?us-ascii?Q?1qjkr2pgs9u3a8vxCcjvA5nkqoH05BjzfU92mpF1d/GC4F5kYNni/RziQKFz?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614b7674-8245-4b62-d152-08db059bb334
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 04:04:08.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyYpvXgEQtZH9PBWzMNZPl1a4AGXXQ8RtBcnlilZ5Pr/Gy0GiQKnx3UtQrPr7jk7i537rr7oYLQ9hubXcXdVN1OxxWHD4bC1oEUfuQXtrGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3582
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Zhi Wang <zhi.wang.linux@gmail.com> Sent: Thursday, February 2, 2023 =
3:01 PM
>=20
> On Sat, 21 Jan 2023 21:45:50 -0500
> Tianyu Lan <ltykernel@gmail.com> wrote:
>=20
> 1) I am thinking if it is a good time to organize a common code path for
> enlightened VM on hyper-v.
>=20
> Wouldn't it be better to have a common flag for enlightened VM?
> Like bool hv_isolation_type_enlightened()
>=20
> Many of the decryption of the post msg page... are also required
> in the enlightened TDX guest, they are not AMD-specific.
>=20
> Then in the "TDX guest on hyper-V" patch set, Dexuan can save some LOCs i=
nstead
> of ending up with if (hv_isolation_type_en_snp() ||
> hv_isolation_type_en_tdx())...

I've had the same thought, and have briefly discussed the
idea with Dexuan and Tianyu.  But there's some code coming
for a non-confidential VM scenario that hasn't yet been posted
upstream, and it adds yet more cases to consider.   We were
thinking to wait a bit until all the cases were evident, and then
find the right simplification.  If we try to do the simplification
now, we may need to do it again.

>=20
> 2) It seems the AMD SEV-SNP enlightened guest on hyper-V is implemented a=
s
> CC_VENDOR_AMD, while TDX enlightened guest is still implemented as
> CC_VENDOR_HYPERV. I am curious about the reason.

Patch set [1] makes CC_VENDOR_HYPERV go away.  Once that
happens, the TDX enlightened guest uses CC_VENDOR_INTEL.

Michael

[1] https://lore.kernel.org/linux-hyperv/1673559753-94403-1-git-send-email-=
mikelley@microsoft.com/T/#m4639d697e9a6619edfcdceffc1b0613a9016f601



>=20
> > From: Tianyu Lan <tiala@microsoft.com>
> >
> > This patchset is to add AMD sev-snp enlightened guest
> > support on hyperv. Hyperv uses Linux direct boot mode
> > to boot up Linux kernel and so it needs to pvalidate
> > system memory by itself.
> >
> > In hyperv case, there is no boot loader and so cc blob
> > is prepared by hypervisor. In this series, hypervisor
> > set the cc blob address directly into boot parameter
> > of Linux kernel. If the magic number on cc blob address
> > is valid, kernel will read cc blob.
> >
> > Shared memory between guests and hypervisor should be
> > decrypted and zero memory after decrypt memory. The data
> > in the target address. It maybe smearedto avoid smearing
> > data.
> >
> > Introduce #HV exception support in AMD sev snp code and
> > #HV handler.
> >
> > Change since v2:
> >        - Remove validate kernel memory code at boot stage
> >        - Split #HV page patch into two parts
> >        - Remove HV-APIC change due to enable x2apic from
> >        	 host side
> >        - Rework vmbus code to handle error of decrypt page
> >        - Spilt memory and cpu initialization patch.
> >
> > Change since v1:
> >        - Remove boot param changes for cc blob address and
> >        use setup head to pass cc blob info
> >        - Remove unnessary WARN and BUG check
> >        - Add system vector table map in the #HV exception
> >        - Fix interrupt exit issue when use #HV exception
> >
> > Ashish Kalra (2):
> >   x86/sev: optimize system vector processing invoked from #HV exception
> >   x86/sev: Fix interrupt exit code paths from #HV exception
> >
> > Tianyu Lan (14):
> >   x86/hyperv: Add sev-snp enlightened guest specific config
> >   x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
> >   x86/hyperv: Set Virtual Trust Level in vmbus init message
> >   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
> >     enlightened guest
> >   clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
> >     enlightened guest
> >   x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
> >   drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
> >     enlightened guest
> >   x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
> >   x86/hyperv: SEV-SNP enlightened guest don't support legacy rtc
> >   x86/hyperv: Add smp support for sev-snp guest
> >   x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
> >   x86/sev: Add a #HV exception handler
> >   x86/sev: Add Check of #HV event in path
> >   x86/sev: Initialize #HV doorbell and handle interrupt requests
> >
> >  arch/x86/entry/entry_64.S             |  82 ++++++
> >  arch/x86/hyperv/hv_init.c             |  43 +++
> >  arch/x86/hyperv/ivm.c                 |  10 +
> >  arch/x86/include/asm/cpu_entry_area.h |   6 +
> >  arch/x86/include/asm/hyperv-tlfs.h    |   4 +
> >  arch/x86/include/asm/idtentry.h       | 105 ++++++-
> >  arch/x86/include/asm/irqflags.h       |  10 +
> >  arch/x86/include/asm/mem_encrypt.h    |   2 +
> >  arch/x86/include/asm/mshyperv.h       |  56 +++-
> >  arch/x86/include/asm/msr-index.h      |   6 +
> >  arch/x86/include/asm/page_64_types.h  |   1 +
> >  arch/x86/include/asm/sev.h            |  13 +
> >  arch/x86/include/asm/svm.h            |  59 +++-
> >  arch/x86/include/asm/trapnr.h         |   1 +
> >  arch/x86/include/asm/traps.h          |   1 +
> >  arch/x86/include/asm/x86_init.h       |   2 +
> >  arch/x86/include/uapi/asm/svm.h       |   4 +
> >  arch/x86/kernel/cpu/common.c          |   1 +
> >  arch/x86/kernel/cpu/mshyperv.c        | 228 ++++++++++++++-
> >  arch/x86/kernel/dumpstack_64.c        |   9 +-
> >  arch/x86/kernel/idt.c                 |   1 +
> >  arch/x86/kernel/sev.c                 | 395 ++++++++++++++++++++++----
> >  arch/x86/kernel/traps.c               |  42 +++
> >  arch/x86/kernel/vmlinux.lds.S         |   7 +
> >  arch/x86/kernel/x86_init.c            |   4 +-
> >  arch/x86/mm/cpu_entry_area.c          |   2 +
> >  drivers/clocksource/hyperv_timer.c    |   2 +-
> >  drivers/hv/connection.c               |   1 +
> >  drivers/hv/hv.c                       |  33 ++-
> >  drivers/hv/hv_common.c                |  26 +-
> >  include/asm-generic/hyperv-tlfs.h     |  19 ++
> >  include/asm-generic/mshyperv.h        |   2 +
> >  include/linux/hyperv.h                |   4 +-
> >  33 files changed, 1102 insertions(+), 79 deletions(-)
> >

